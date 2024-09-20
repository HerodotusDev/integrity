from starkware.cairo.lang.compiler.parser import parse_file
from starkware.cairo.lang.compiler.ast.code_elements import *
from starkware.cairo.lang.compiler.ast.expr import *
from starkware.cairo.lang.compiler.ast.expr_func_call import *
import requests

settings = {
    # 'OPTIMIZE_VALUE_ARRAY': False,
    # 'OPTIMIZE_OODS_ARRAY': False,
}

global array_read_offset
global constants

functions = {
    'eval_composition_polynomial': lambda x: f"""\
fn eval_composition_polynomial_inner{x}(
    mut mask_values: Span<felt252>,
    mut constraint_coefficients: Span<felt252>,
    point: felt252,
    trace_generator: felt252,
    global_values: GlobalValues,
) -> felt252""",
    'eval_oods_polynomial': lambda x: f"""\
fn eval_oods_polynomial_inner{x}(
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
    'return total_sum;\n': '',
}

def apply_manual_corrections(line: str) -> str:
    return manual_corrections.get(line, line)


class NodeType:
    def __repr__(self):
        return self.__class__.__name__

class Comment(NodeType):
    def __init__(self, comment: str):
        self.comment = comment

class Expression(NodeType):
    def __init__(self, deps: set[str], pops=set):
        self.deps = deps # direct variable dependencies
        self.pops = pops # which spans are popped
    
    def __repr__(self):
        return f"Expression(deps={self.deps}, pops={self.pops})"

class VariableDeclaration(Expression):
    def __init__(self, name: str, deps: set[str], pops=set):
        self.name = name # initialized variable name
        self.unused = False
        super().__init__(deps, pops)
    
    def __repr__(self):
        return f"VariableDeclaration(name={self.name}, deps={self.deps}, pops={self.pops})"


def parse_and_combine(a: AstNode, b: AstNode) -> tuple[str, str, NodeType]:
    parsed_a, type_a = parse(a)
    parsed_b, type_b = parse(b)
    assert isinstance(type_a, Expression) and isinstance(type_b, Expression)
    out_type = Expression(type_a.deps.union(type_b.deps), type_a.pops.union(type_b.pops))
    return parsed_a, parsed_b, out_type


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


def parse(node: AstNode, comment: str = '') -> tuple[str, NodeType]:
    global array_read_offset
    match node:
        case CodeElementAllocLocals(): # alloc_locals
            return ('', NodeType())
        
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
            parsed, expr_type = parse(expr)
            name = rename_var(name)
            assert isinstance(expr_type, Expression)
            decl_type = VariableDeclaration(name, expr_type.deps, expr_type.pops)
            return (f"let {name} = {parsed};{com}\n\t", decl_type)
    
        case RvalueFuncCall( # safe_div(x, y)
            func_ident=ExprIdentifier(name='safe_div'),
            arguments=ArgList(args=[
                lv,
                rv
            ])
        ):
            parsed_a, parsed_b, out_type = parse_and_combine(lv, rv)
            # TODO: should this be safe_div?
            return (f"{parsed_a} / {parsed_b}", out_type)

        case RvalueFuncCall( # safe_mult(x,y)
            func_ident=ExprIdentifier(name='safe_mult'),
            arguments=ArgList(args=[
                lv,
                rv
            ])
        ):
            parsed_a, parsed_b, out_type = parse_and_combine(lv, rv)
            # TODO: should this be safe_mult?
            return (f"{parsed_a} * {parsed_b}", out_type)

        case RvalueFuncCall( # f(x, y, ...)
            func_ident=ExprIdentifier(name=name),
            arguments=ArgList(args=args),
        ):
            def remove_parenthesis(arg):
                match arg:
                    case ExprAssignment(expr=ExprParentheses(val=val)):
                        return val
                return arg
            deps = set()
            pops = set()
            parsed = []
            for arg in args:
                p, expr_type = parse(remove_parenthesis(arg))
                parsed.append(p)
                deps = deps.union(expr_type.deps)
                pops = pops.union(expr_type.pops)

            return f"{name}({', '.join(parsed)})", Expression(deps, pops)
        
        case ExprOperator(a=a, b=b, op=op): # x + y
            parsed_a, parsed_b, out_type = parse_and_combine(a, b)
            return f"{parsed_a} {op} {parsed_b}", out_type

        case ExprSubscript( # x[0]
            expr=ExprIdentifier(name=name),
            offset=ExprConst(val=val)
        ) if val == array_read_offset.get(name, 0):
            array_read_offset[name] = array_read_offset.get(name, 0) + 1
            return f"*{name}.pop_front().unwrap()", Expression(set(), set([name]))

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
                return f"*{name}.pop_front().unwrap()", Expression(set(), set([name]))
        
        case CodeElementStaticAssert(a=a, b=b): # static assert x == y
            return f"assert({parse(a)[0]} == {parse(b)[0]}, 'Autogenerated assert failed');\n\t", NodeType()

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
            return f"return {var};\n", NodeType()
        
        case ExprParentheses(val=val): # (x)
            parsed = parse(val)
            return f"({parsed[0]})", parsed[1]

        case ExprIdentifier(name=name): # x
            name = rename_var(name)
            return name, Expression(set([name]), set())
        
        case ExprConst(format_str=format_str):
            return format_str, Expression(set(), set())
        
        case ExprAssignment(expr=expr):
            return parse(expr)
        
        case ExprFuncCall(rvalue=rvalue):
            return parse(rvalue)

        case CommentedCodeElement(code_elm=code_elm, comment=comment):
            return parse(code_elm, comment)

        case CodeElementEmptyLine():
            if comment is None:
                return '\n\t', NodeType()
            return '//' + comment + '\n\t', Comment(comment)

    print(node.__class__.__name__, 'not implemented')
    print(node, "\n")
    return ''


def handle_block(func_name: str, acc: list[tuple[str, NodeType]], split_lengths: list[int], val_opt_level = 0) -> str:
    # find total_sum start point
    total_sum_start = None
    for i, (_, t) in enumerate(acc):
        if isinstance(t, VariableDeclaration) and t.name == 'total_sum' and len(t.deps) == 0 and len(t.pops) == 0:
            total_sum_start = i
            break
    if total_sum_start is None:
        raise Exception('total_sum declaration not found')
    
    decl_part, sum_part = acc[:total_sum_start], acc[total_sum_start+1:]
    sum_chunks = [[]]
    for line in sum_part:
        sum_chunks[-1].append(line)
        if isinstance(line[1], VariableDeclaration) and line[1].name == 'total_sum':
            sum_chunks.append([])

    # total_sum splitting
    if split_lengths:
        new_chunks = []
        curr_chunk = []
        curr_chunk_len = 0
        i = 0
        for chunk in sum_chunks:
            curr_chunk += chunk
            curr_chunk_len += 1
            try:
                if curr_chunk_len >= split_lengths[i]:
                    new_chunks.append(curr_chunk)
                    curr_chunk = []
                    curr_chunk_len = 0
                    i += 1
            except IndexError:
                raise Exception('Split lengths exhausted')
        if curr_chunk:
            raise Exception('Split lengths has values left')
        sum_chunks = new_chunks

        used_decl_part = []
        for chunk in sum_chunks:
            referenced_vars = set()
            for _,t in chunk:
                if isinstance(t, VariableDeclaration):
                    referenced_vars = referenced_vars.union(t.deps)
            
            for line in decl_part[::-1]:
                _, t = line
                if isinstance(t, VariableDeclaration):
                    if t.name not in referenced_vars:
                        t.unused = True
                    else:
                        referenced_vars.remove(t.name)
                        referenced_vars = referenced_vars.union(t.deps)
            
            used_decl_part.append([])
            for l,t in decl_part:
                if isinstance(t, VariableDeclaration) and t.unused:
                    if len(t.pops) == 0:
                        continue
                    else:
                        used_decl_part[-1].append((l.replace('let ', 'let _'), t))
                else:
                    used_decl_part[-1].append((l, t))
            
            for _, t in decl_part:
                if isinstance(t, VariableDeclaration):
                    t.unused = False
        
        decl_part = [decl_part] + used_decl_part
        sum_part = [sum_part] + sum_chunks
    else:
        decl_part = [decl_part]
        sum_part = [sum_part]
    
    if val_opt_level >= 1:
        acc = []
        for i, (sum_p, decl_p) in enumerate(zip(sum_part, decl_part)):
            part_number = f"_part{i}" if split_lengths and len(split_lengths) > 1 and i > 0 else ""
            # val_opt_level = 1:
            var_lines = []
            sum_line = None
            # val_opt_level = 2:
            pow_lines = []
            cols = []
            # common:
            other_lines = []
            comments = []
            accept_var_lines = True
            decl = [x[0] for x in decl_p if not(isinstance(x[1], VariableDeclaration) and x[1].unused)]
            for line,t in sum_p:
                if not accept_var_lines:
                    other_lines.append(line)
                elif isinstance(t, Comment):
                    comments.append((line, t))
                elif isinstance(t, VariableDeclaration) and t.name == 'value':
                    if val_opt_level == 1:
                        # leave whole value, take out total_sum
                        adjusted_line = line.replace('let value = ', '').replace(';', ',')
                        var_lines.append(('\t' + adjusted_line, t))
                        if len(comments) == 1:
                            var_lines[-1] = var_lines[-1][0].rstrip() + comments[0][0]
                            comments = []
                        if len(comments) > 1:
                            raise Exception('More than one comment per value declaration')
                    else:
                        # leave pow, take out value and total_sum
                        m = re.match(r'let value = \((\w+) - \*oods_values\.pop_front\(\)\.unwrap\(\)\) \/ \(point - (\w+) \* oods_point\);\n\t', line)
                        if m is None:
                            raise Exception("value declaration didn't match the pattern", line)
                        adjusted_line = m.groups()[1] + ',\n\t'
                        col = m.groups()[0]
                        if len(cols) == 0 or cols[-1] != col:
                            cols.append(col)
                            pow_lines.append([])
                        pow_lines[-1].append(adjusted_line)
                elif line.strip() != '':
                    if sum_line is None:
                        sum_line = line
                    elif sum_line != line:
                        accept_var_lines = False
                        other_lines += [x[0] for x in comments]
                        other_lines.append(line)
            sum_line = sum_line.replace('let total_sum = total_sum + ', 'total_sum += ')
            feature = f"#[cfg(feature: '{'monolith' if i == 0 else 'split'}')]" if split_lengths else ''
            if val_opt_level == 1:
                sum_line = 'let mut total_sum = 0;\n\tfor value in values {\n\t\t' + sum_line.replace('value', '*value') + '};\n\t\n\t'
                acc += [feature + functions[func_name](part_number) + ' {'] + decl + ['\n\tlet values = [\n\t'] + var_lines + ['].span();\n\t\n\t' + sum_line] + other_lines + ['total_sum\n}\n\n']
            elif val_opt_level == 2:
                output = ['let mut total_sum = 0;\n\t']
                for pows, col in zip(pow_lines, cols):
                    output.append('let pows = [\n\t\t' + '\t'.join(pows) + '].span();\n\t')
                    output.append(f'for pow in pows {{\n\t\tlet value = ({col} - *oods_values.pop_front().unwrap()) / (point - *pow * oods_point);\n\t\t{sum_line}}};\n\t\n\t')
                acc += [feature + functions[func_name](part_number) + ' {'] + decl + output + other_lines + ["total_sum\n}\n\n"]
                
        # todo handle not optimized
    
    # for chunk in sum_chunks:
    #     print("CHUNK")
    #     for line in chunk:
    #         print(line[0], '-', line[1])

    return ''.join([apply_manual_corrections(x) for x in acc])

def handle_github_file(url, output_file, layout, settings_override={}):
    global settings

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
                print(name)
                settings = settings_override[name]
                array_read_offset = {}

                if isinstance(code_block, CodeBlock):
                    code_elements = code_block.code_elements
                    acc = [parse(ce) for ce in code_elements]
                    parsed = handle_block(name, acc, settings.get('split'), settings.get('value_opt_level'))
                else:
                    raise Exception('Code block not found')
                
                if name in functions_result:
                    raise Exception(name + ' defined multiple times')
                functions_result[name] = parsed
            case CodeElementConst(identifier=ExprIdentifier(name=name), expr=expr):
                constants[name] = eval(expr)

    with open(output_file, 'w') as f:
        f.write(imports(layout) + ''.join(functions_result.values()))


def main():
    # layouts = ('recursive', 'recursive_with_poseidon', 'small', 'dex', 'starknet', 'starknet_with_keccak')
    layouts = ('starknet_with_keccak', )
    optimizations = {
        'OPTIMIZE_VALUE_ARRAY': {'recursive', 'starknet', 'starknet_with_keccak'},
        'OPTIMIZE_OODS_ARRAY': {'starknet', 'starknet_with_keccak'},
    }

    for layout in layouts:
        handle_github_file(
            f"https://raw.githubusercontent.com/starkware-libs/cairo-lang/master/src/starkware/cairo/stark_verifier/air/layouts/{layout}/autogenerated.cairo",
            f"../{layout}/autogenerated.cairo",
            layout,
            {
                'recursive': {
                    'eval_composition_polynomial': {
                        'value_opt_level': 1,
                    },
                    'eval_oods_polynomial': {
                        'value_opt_level': 2
                    },
                },
                'starknet_with_keccak': {
                    'eval_composition_polynomial': {
                        'split': [219, 69, 60],
                        'value_opt_level': 1
                    },
                    'eval_oods_polynomial': {
                        'value_opt_level': 2
                    },
                }
                # 'OPTIMIZE_VALUE_ARRAY': layout in optimizations['OPTIMIZE_VALUE_ARRAY'],
                # 'OPTIMIZE_OODS_ARRAY': layout in optimizations['OPTIMIZE_OODS_ARRAY'],
            }[layout]
        )


if __name__ == '__main__':
    main()
