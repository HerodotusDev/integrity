import re
from random import random
import sys 

sys.setrecursionlimit(10**6) 

all_vars = {}
extern = {}
last_override = {}
code = []
comment_before = []

def get_visited(vertex, excluded):
    visited = set()
    def dfs(v):
        visited.add(v)
        for u in all_vars[v]:
            if u not in visited and u not in excluded:
                dfs(u)
    dfs(vertex)
    return visited

def get_renamed(varname):
    if varname not in all_vars:
        return varname
    i = 1
    while True:
        new_varname = varname + '__' + str(i)
        if new_varname not in all_vars:
            return new_varname
        i += 1


def get_code(set):
    s = ""
    pop_count = 0
    for (var, line), comment in zip(code, comment_before):
        if var in set:
            if pop_count > 0:
                s += f'mask_values = mask_values.slice({pop_count}, mask_values.len() - {pop_count});\n    '
                pop_count = 0
            s += comment
            s += line
        elif line.find('mask_values.pop_front().unwrap()') != -1:
            s += comment
            pop_count += 1
    if pop_count > 0:
        s += f'mask_values = mask_values.slice({pop_count}, mask_values.len() - {pop_count});\n    '
    return s


with open('starknet_with_keccak.txt') as f:
    vars = f.read().split('let')
    comment_before.append('    // ' + vars[0].split('// ')[1])
    for var in vars[1:]:
        # print('========')
        s = var.split('    // ')
        if len(s) > 1:
            var = s[0] + '    '
            comment_before.append('// ' + s[1])
        else:
            var = s[0]
            comment_before.append('')

        varname, assign = ' '.join([x.strip() for x in var.strip().split('\n')]).split(' = ')
        renamed_var = get_renamed(varname)
        dependencies = re.findall(r"([a-zA-Z_][a-zA-Z0-9_]*)", assign)
        all_vars[renamed_var] = []
        extern[renamed_var] = []
        for d in dependencies:
            if d in last_override:
                all_vars[renamed_var].append(last_override[d])
            else:
                extern[renamed_var].append(d)
        last_override[varname] = renamed_var
        code.append((renamed_var, 'let' + var))
        # print(renamed_var)
        # print(all_vars[renamed_var], extern[renamed_var])

    # print(all_vars.keys())
    split_points = [
        'total_sum__95',
        'total_sum__195',
        'total_sum__229',
        'total_sum__260',
        'total_sum__285',
        'total_sum__310',
        'total_sum__347',
    ]
    prev = set()
    parts = []
    for s in split_points:
        parts.append(get_visited(s, prev))
        prev = {s}
    # print(len(part4))
    # part2 = get_visited('total_sum__198', {'total_sum__99'})
    
    with open('starknet_with_keccak_2.out', 'w') as f:
        f.write(get_code(parts[2]))
    # print(get_code(part2))