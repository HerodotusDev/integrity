from starkware.cairo.lang.compiler.parser import parse_file
from starkware.cairo.lang.compiler.ast.code_elements import *
from starkware.cairo.lang.compiler.ast.expr import *
from starkware.cairo.lang.compiler.ast.expr_func_call import *
import requests

OPTIMIZE_VALUE_ARRAY = False

global array_read_offset
global constants

functions = {
    'eval_composition_polynomial': """\
fn eval_composition_polynomial_inner(
    mut mask_values: Span<felt252>,
    mut constraint_coefficients: Span<felt252>,
    point: felt252,
    trace_generator: felt252,
    global_values: GlobalValues,
) -> felt252""",
    'eval_oods_polynomial': """\
fn eval_oods_polynomial_inner(
    mut column_values: Span<felt252>,
    mut oods_values: Span<felt252>,
    mut constraint_coefficients: Span<felt252>,
    point: felt252,
    oods_point: felt252,
    trace_generator: felt252,
) -> felt252""",
}

imports = lambda layout: f"""\
use cairo_verifier::{{
    air::layouts::{layout}::{{
        global_values::GlobalValues,
        constants::{{CONSTRAINT_DEGREE, NUM_COLUMNS_FIRST, NUM_COLUMNS_SECOND, MASK_SIZE}},
    }},
    common::math::{{Felt252Div, pow}},
}};\n
"""

manual_corrections = {
    'let oods_point_to_deg = pow(oods_point, CONSTRAINT_DEGREE);\n\t': 'let oods_point_to_deg = pow(oods_point, CONSTRAINT_DEGREE.into());\n\t',
    'return total_sum;\n': 'total_sum\n',
}

def apply_manual_corrections(line: str) -> str:
    return manual_corrections.get(line, line)

class LineType:
    pass

class LineTypeUnknown(LineType):
    pass

class LineTypeEmpty(LineType):
    pass

class LineTypeComment(LineType):
    pass

class LineTypeVarPop(LineType):
    def __init__(self, assigned_var: str, pop_var: str):
        self.assigned_var = assigned_var
        self.pop_var = pop_var

class LineTypeValueCalc(LineType):
    def __init__(self, expr: str, comment: str):
        self.expr = expr
        self.comment = comment

class LineTypeTotalSum(LineType):
    pass


def optimize(lines: list[tuple[str, LineType]]) -> str:
    acc = ''
    acc_var_pops = []
    var_pops_varname = None
    latest_value_comment = None
    acc_values = []
    acc_total_sum = []
    for (line, line_type), (_, next_line_type) in zip(lines, lines[1:] + [(None, None)]):
        # If subsequent lines are pop_front() from the same array, we can combine them into a single multi_pop_front.
        if isinstance(line_type, LineTypeVarPop):
            acc_var_pops.append(rename_var(line_type.assigned_var))
            var_pops_varname = line_type.pop_var
            if not (isinstance(next_line_type, LineTypeVarPop) and line_type.pop_var == next_line_type.pop_var):
                vars_arr = ', '.join(acc_var_pops)
                vars_len = str(len(acc_var_pops))
                acc += F"let [{vars_arr}] = (*{var_pops_varname}.multi_pop_front::<{vars_len}>().unwrap()).unbox();\n\t"
                acc_var_pops = []
        elif OPTIMIZE_VALUE_ARRAY and isinstance(line_type, LineTypeValueCalc):
            line_type.comment = latest_value_comment
            acc_values.append(line_type)
        elif OPTIMIZE_VALUE_ARRAY and isinstance(line_type, LineTypeTotalSum):
            acc_total_sum.append(line)
        elif OPTIMIZE_VALUE_ARRAY and isinstance(line_type, LineTypeComment) and isinstance(next_line_type, LineTypeValueCalc):
            # comments before value calculations are moved to the value calculation line
            pass
        else:
            if OPTIMIZE_VALUE_ARRAY and not isinstance(line_type, LineTypeEmpty) and acc_values:
                total_sum_line = None
                # assert that all total sum calculations are the same
                for x,y in zip(acc_total_sum, acc_total_sum[1:]):
                    if x == 'let total_sum = 0;\n\t':
                        continue
                    total_sum_line = x
                    if x != y:
                        raise Exception("Total sum calculations are not the same " + x + y)
                    
                acc += 'let values = [\n\t\t'
                acc += '\n\t\t'.join([f"{v.expr},{' '+v.comment.rstrip('\n\t') if v.comment is not None else ''}" for v in acc_values])
                acc += '\n\t].span();\n\t\n\t'
                acc += 'for value in values {\n\t\t' + total_sum_line + '};\n\t'
                acc_values = []
                acc_total_sum = []
        
            # eliminate triple newlines
            if not (acc.endswith('\n\t\n\t') and line == '\n\t'):
                acc += apply_manual_corrections(line)

        latest_value_comment = line if isinstance(line_type, LineTypeComment) else None
    return acc


def eval(node: AstNode) -> int:
    match node:
        case ExprOperator(a=a, b=b, op='+'):
            return eval(a) + eval(b)
        
        case ExprIdentifier(name=name) if name in constants:
            return constants[name]

        case ExprConst(val=val):
            return val

    print(node.__class__.__name__, 'not implemented in eval')
    print(node, "\n")
    return 0


def rename_var(name: str) -> str:
    return name.replace("__", "_")


def parse(node: AstNode, comment: str = '') -> tuple[str, LineType]:
    global array_read_offset
    match node:
        case CodeBlock(code_elements=code_elements):
            acc = [parse(ce) for ce in code_elements]
            return (optimize(acc), LineTypeUnknown())

        case CodeElementAllocLocals(): # alloc_locals
            return ('', LineTypeEmpty())
        
        case CodeElementLocalVariable( # local x
            typed_identifier=TypedIdentifier(
                identifier=ExprIdentifier(name=name)
            ),
            expr=expr
        ) | CodeElementUnpackBinding( # let (local x)
            unpacking_list=IdentifierList(
                identifiers=[
                    TypedIdentifier(identifier=ExprIdentifier(name=name))
                ]
            ),
            rvalue=expr
        ) | CodeElementTemporaryVariable( # tempvar x
            typed_identifier=TypedIdentifier(
                identifier=ExprIdentifier(name=name)
            ),
            expr=expr
        ):
            com = '' if comment is None else (' //' + comment)
            parsed = list(parse(expr))
            name = rename_var(name)
            if isinstance(parsed[1], LineTypeVarPop):
                parsed[1].assigned_var = name
            if name == 'value':
                parsed[1] = LineTypeValueCalc(parsed[0], com)
            elif name == 'total_sum':
                parsed[1] = LineTypeTotalSum()
            return (f"let {name} = {parsed[0]};{com}\n\t", parsed[1])
    
        case RvalueFuncCall( # safe_div(x, y)
            func_ident=ExprIdentifier(name='safe_div'),
            arguments=ArgList(args=[
                lv,
                rv
            ])
        ):
            # TODO: should this be safe_div?
            return (f"{parse(lv)[0]} / {parse(rv)[0]}", LineTypeUnknown())

        case RvalueFuncCall( # safe_mult(x,y)
            func_ident=ExprIdentifier(name='safe_mult'),
            arguments=ArgList(args=[
                lv,
                rv
            ])
        ):
            # TODO: should this be safe_mult?
            return (f"{parse(lv)[0]} * {parse(rv)[0]}", LineTypeUnknown())

        case RvalueFuncCall( # f(x, y, ...)
            func_ident=ExprIdentifier(name=name),
            arguments=ArgList(args=args),
        ):
            def remove_parenthesis(arg):
                match arg:
                    case ExprAssignment(expr=ExprParentheses(val=val)):
                        return val
                return arg
            return f"{name}({', '.join([parse(remove_parenthesis(arg))[0] for arg in args])})", LineTypeUnknown()
        
        case ExprOperator(a=a, b=b, op=op):
            return f"{parse(a)[0]} {op} {parse(b)[0]}", LineTypeUnknown()

        case ExprSubscript( # x[0]
            expr=ExprIdentifier(name=name),
            offset=ExprConst(val=val)
        ) if val == array_read_offset.get(name, 0):
            array_read_offset[name] = array_read_offset.get(name, 0) + 1
            return f"*{name}.pop_front().unwrap()", LineTypeVarPop(None, name)

        case ExprSubscript( # x[CONST_VAR]
            expr=ExprIdentifier(name=name),
            offset=offset
        ):
            evaluated_offset = eval(offset)
            curr = array_read_offset.get(name, 0)
            if curr != evaluated_offset:
                print(f"Array read not subsequent. Expected {curr}, actual {evaluated_offset}")
            else:
                array_read_offset[name] = curr + 1
                return f"*{name}.pop_front().unwrap()", LineTypeUnknown()
        
        case CodeElementStaticAssert(a=a, b=b): # static assert x == y
            return f"assert({parse(a)[0]} == {parse(b)[0]}, 'Autogenerated assert failed');\n\t", LineTypeUnknown()

        case CodeElementReturn( # return (res=x)
            expr=ExprTuple(
                members=ArgList(
                    args=[
                        ExprAssignment(
                            identifier=ExprIdentifier(name='res'),
                            expr=ExprIdentifier(name=var),
                        )
                    ]
                )
            )
        ):
            return f"return {var};\n", LineTypeUnknown()
        
        case ExprParentheses(val=val): # (x)
            parsed = parse(val)
            return f"({parsed[0]})", parsed[1]

        case ExprIdentifier(name=name): # x
            return rename_var(name), LineTypeUnknown()
        
        case ExprConst(format_str=format_str):
            return format_str, LineTypeUnknown()
        
        case ExprAssignment(expr=expr):
            return parse(expr)
        
        case ExprFuncCall(rvalue=rvalue):
            return parse(rvalue)

        case CommentedCodeElement(code_elm=code_elm, comment=comment):
            return parse(code_elm, comment)

        case CodeElementEmptyLine():
            if comment is None:
                return '\n\t', LineTypeEmpty()
            return '//' + comment + '\n\t', LineTypeComment()

    print(node.__class__.__name__, 'not implemented')
    print(node, "\n")
    return ''


def handle_github_file(url, output_file, layout):
    global array_read_offset
    response = requests.get(url)
    if response.status_code != 200:
        raise Exception(f"Failed to fetch {url}")

    ast = parse_file(response.text, filename='autogenerated.cairo')

    global constants
    constants = {}

    functions_result = {}
    for commented_code_element in ast.code_block.code_elements:
        match commented_code_element.code_elm:
            case CodeElementFunction(
                element_type='func',
                identifier=ExprIdentifier(name=name),
                code_block=code_block
            ) if name in functions:
                array_read_offset = {}
                parsed = parse(code_block)[0]
                if name in functions_result:
                    raise Exception(name + ' defined multiple times')
                functions_result[name] = functions[name] + ' {' + parsed + "}\n"
            case CodeElementConst(identifier=ExprIdentifier(name=name), expr=expr):
                constants[name] = eval(expr)

    with open(output_file, 'w') as f:
        f.write(imports(layout) + '\n'.join(functions_result.values()))


def main():
    # layouts = ('recursive', 'recursive_with_poseidon', 'small', 'dex', 'starknet', 'starknet_with_keccak')
    layouts = ('recursive', 'recursive_with_poseidon', 'small', 'dex')

    for layout in layouts:
        handle_github_file(
            f"https://raw.githubusercontent.com/starkware-libs/cairo-lang/master/src/starkware/cairo/stark_verifier/air/layouts/{layout}/autogenerated.cairo",
            f"../{layout}/autogenerated.cairo",
            layout
        )


if __name__ == '__main__':
    main()
