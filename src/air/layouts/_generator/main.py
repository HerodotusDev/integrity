from starkware.cairo.lang.compiler.parser import parse_file
from starkware.cairo.lang.compiler.ast.code_elements import *
from starkware.cairo.lang.compiler.ast.expr import *
from starkware.cairo.lang.compiler.ast.expr_func_call import *
from itertools import zip_longest, tee
import requests
from enum import Enum

def pair_with_next(iterable, fill=None):
    a, b = tee(iterable)
    next(b)
    return zip_longest(a, b, fillvalue=fill)

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
use integrity::{{
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

class OptLevel(Enum):
    NONE = 0
    VALUE_ARRAY = 1
    POW_ARRAY = 2

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


def handle_block(func_name: str, lines: list[tuple[str, NodeType]], settings = {}) -> str:
    split_part_lengths = settings.get('split')
    val_opt_level = settings.get('value_opt_level', OptLevel.NONE)

    # find total_sum start point
    total_sum_start = None
    for i, (_, t) in enumerate(lines):
        if isinstance(t, VariableDeclaration) and t.name == 'total_sum' and len(t.deps) == 0 and len(t.pops) == 0:
            total_sum_start = i
            break
    if total_sum_start is None:
        raise Exception('total_sum declaration not found')
    
    # decl_part - declaration of pow, domain and other intermediate values
    # sum_part - calculation of value and total_sum
    decl_part, sum_part = lines[:total_sum_start], lines[total_sum_start+1:]

    # divide sum_part into chunks
    # one chunk contains one value and one total_sum (except for last chunk)
    sum_chunks = [[]]
    for line in sum_part:
        sum_chunks[-1].append(line)
        if isinstance(line[1], VariableDeclaration) and line[1].name == 'total_sum':
            sum_chunks.append([])

    # split total_sum chunks into parts so that i-th part has split_part_lengths[i] chunks
    if split_part_lengths:
        parts = [] # i-th value is an array of lines for i-th part
        curr_part = [] # array of lines for current part
        curr_part_len = 0 # number of chunks in current part
        i = 0
        for chunk in sum_chunks:
            curr_part += chunk
            curr_part_len += 1
            try:
                if curr_part_len >= split_part_lengths[i]:
                    parts.append(curr_part)
                    curr_part = []
                    curr_part_len = 0
                    i += 1
            except IndexError:
                raise Exception('`split` argument indicates too few lines')
        if curr_part:
            raise Exception('`split` argument indicates too many lines')

        used_decl_part = [] # decl_part with unused variables removed
        for part in parts:
            referenced_vars = set() # set of variables that are referenced by next lines

            # all variables in total_sum part should be included
            for _, t in part:
                if isinstance(t, VariableDeclaration):
                    referenced_vars = referenced_vars.union(t.deps)
            
            # starting from the end, mark unused variables and update referenced_vars
            for _, t in decl_part[::-1]:
                if isinstance(t, VariableDeclaration):
                    if t.name not in referenced_vars:
                        t.unused = True
                    else:
                        referenced_vars.remove(t.name)
                        referenced_vars = referenced_vars.union(t.deps)
            
            used_decl_part.append([])
            for l, t in decl_part:
                if isinstance(t, VariableDeclaration) and t.unused:
                    if len(t.pops) == 0:
                        # unused declarations with no pops can be removed
                        continue
                    else:
                        # unused declarations with pops cannot be removed entirely
                        # so they should be prefixed with _
                        used_decl_part[-1].append((l.replace('let ', 'let _'), t))
                else:
                    used_decl_part[-1].append((l, t))
            
            # reset unused for next part calculation
            for _, t in decl_part:
                if isinstance(t, VariableDeclaration):
                    t.unused = False
        
        decl_part = [decl_part] + used_decl_part
        sum_part = [sum_part] + parts
    else:
        decl_part = [decl_part]
        sum_part = [sum_part]
    
    acc = []
    for i, (sum_p, decl_p) in enumerate(zip(sum_part, decl_part)):
        part_number = f"_part{i}" if split_part_lengths and len(split_part_lengths) > 1 and i > 0 else ""
        # val_opt_level = 1:
        var_lines = []
        sum_line = None
        # val_opt_level = 2:
        pow_lines = []
        cols = []
        # common:
        other_lines = []
        comments = []

        # whether variable declaration should be handled separately
        # it is turned on only if optimization is enabled
        accept_var_lines = val_opt_level != OptLevel.NONE

        # optimize variable multi_pop
        # unused variables followed by used variables should be prefixed with _
        # unused variables at the end should be removed from the declaration
        decl = []
        pop_var = ''
        assigned_vars = []
        unused_assigned_vars = []
        for (l, t), (_, next_t) in pair_with_next(decl_p, fill=(None, None)):
            if isinstance(t, VariableDeclaration) and len(t.deps) == 0 and len(t.pops) == 1:
                pop_var = next(iter(t.pops))
                if l.startswith('let _'): # unused
                    unused_assigned_vars.append('_' + t.name)
                else: # used
                    assigned_vars += unused_assigned_vars
                    unused_assigned_vars = []
                    assigned_vars.append(t.name)
                if not isinstance(next_t, VariableDeclaration) or next(iter(t.pops)) != pop_var:
                    decl.append(f'let [{', '.join(assigned_vars)}] = (*{pop_var}.multi_pop_front::<{len(assigned_vars)}>().unwrap()).unbox();\n\t')
                    assigned_vars = []
                    unused_assigned_vars = []
            else:
                decl.append(l)
        
        for line,t in sum_p:
            if not accept_var_lines:
                other_lines.append(line)
            elif isinstance(t, Comment):
                comments.append(line)
            elif isinstance(t, VariableDeclaration) and t.name == 'value':
                if val_opt_level == OptLevel.VALUE_ARRAY:
                    # leave whole value, take out total_sum
                    adjusted_line = line.replace('let value = ', '').replace(';', ',')
                    var_lines.append('\t' + adjusted_line)
                    if len(comments) == 1:
                        var_lines[-1] = var_lines[-1].rstrip() + comments[0]
                        comments = []
                    if len(comments) > 1:
                        raise Exception('More than one comment per value declaration')
                if val_opt_level == OptLevel.POW_ARRAY:
                    # leave pow, take out value and total_sum
                    m = re.match(r'let value = \((\w+) - \*oods_values\.pop_front\(\)\.unwrap\(\)\) \/ \(point - (\w+) \* oods_point\);\n\t', line)
                    if m is None:
                        raise Exception("value declaration didn't match the pattern", line)
                    col = m.groups()[0]
                    adjusted_line = m.groups()[1] + ',\n\t'
                    if len(cols) == 0 or cols[-1] != col:
                        cols.append(col)
                        pow_lines.append([])
                    pow_lines[-1].append(adjusted_line)
            elif line.strip() != '':
                if sum_line is None:
                    sum_line = line
                elif sum_line != line:
                    accept_var_lines = False
                    other_lines += comments
                    other_lines.append(line)
        if split_part_lengths:
            acc.append(f"#[cfg(feature: '{'monolith' if i == 0 else 'split'}')]")
        acc.append(functions[func_name](part_number) + ' {')
        acc += decl
        match val_opt_level:
            case OptLevel.VALUE_ARRAY:
                sum_line = sum_line.replace('let total_sum = total_sum + ', 'total_sum += ')
                sum_loop = 'let mut total_sum = 0;\n\tfor value in values {\n\t\t' + sum_line.replace('value', '*value') + '};\n\t\n\t'
                acc.append('\n\tlet values = [\n\t')
                acc += var_lines
                acc.append('].span();\n\t\n\t')
                acc.append(sum_loop)
            case OptLevel.POW_ARRAY:
                sum_line = sum_line.replace('let total_sum = total_sum + ', 'total_sum += ')
                acc.append('let mut total_sum = 0;\n\t')
                for pows, col in zip(pow_lines, cols):
                    acc.append('let pows = [\n\t\t' + '\t'.join(pows) + '].span();\n\t')
                    acc.append(f'for pow in pows {{\n\t\tlet value = ({col} - *oods_values.pop_front().unwrap()) / (point - *pow * oods_point);\n\t\t{sum_line}}};\n\t\n\t')
            case OptLevel.NONE:
                acc.append('let total_sum = 0;\n\t')
        
        acc += other_lines
        acc.append('total_sum\n}\n\n')
    
    return ''.join([apply_manual_corrections(x) for x in acc])

def handle_github_file(url, output_file, layout, settings={}):
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
                array_read_offset = {}

                if isinstance(code_block, CodeBlock):
                    code_elements = code_block.code_elements
                    acc = [parse(ce) for ce in code_elements]
                    parsed = handle_block(name, acc, settings.get(name, {}))
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
    layout_settings = {
        'recursive': {
            'eval_oods_polynomial': { 'value_opt_level': OptLevel.VALUE_ARRAY },
            'eval_composition_polynomial': { 'value_opt_level': OptLevel.VALUE_ARRAY },
        },
        'recursive_with_poseidon': {
            'eval_oods_polynomial': { 'value_opt_level': OptLevel.NONE },
            'eval_composition_polynomial': { 'value_opt_level': OptLevel.NONE },
        },
        'small': {
            'eval_oods_polynomial': { 'value_opt_level': OptLevel.NONE },
            'eval_composition_polynomial': { 'value_opt_level': OptLevel.NONE },
        },
        'dex': {
            'eval_oods_polynomial': { 'value_opt_level': OptLevel.NONE },
            'eval_composition_polynomial': { 'value_opt_level': OptLevel.NONE },
        },
        'starknet': {
            'eval_oods_polynomial': { 'value_opt_level': OptLevel.POW_ARRAY },
            'eval_composition_polynomial': { 'value_opt_level': OptLevel.VALUE_ARRAY },
        },
        'starknet_with_keccak': {
            'eval_oods_polynomial': { 'value_opt_level': OptLevel.POW_ARRAY },
            'eval_composition_polynomial': {
                'split': [219, 69, 60],
                'value_opt_level': OptLevel.VALUE_ARRAY,
            },
        }
    }

    for layout, settings in layout_settings.items():
        handle_github_file(
            f"https://raw.githubusercontent.com/starkware-libs/cairo-lang/a86e92bfde9c171c0856d7b46580c66e004922f3/src/starkware/cairo/stark_verifier/air/layouts/{layout}/autogenerated.cairo",
            f"../{layout}/autogenerated.cairo",
            layout,
            settings
        )


if __name__ == '__main__':
    main()
