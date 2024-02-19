import argparse
from pathlib import Path
import re
import sys


hashers = ('KECCAK', 'BLAKE')

def process_file(file_path, type):
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            lines = file.readlines()
    except UnicodeDecodeError:
        print(f"Skipping file due to encoding issue: {file_path}")
        return  # Skip this file

    in_block = False
    current_block_type = None
    modified_lines = []

    for line in lines:
        begin_match = re.match(r'^// === ([A-Z]+) ONLY BEGIN ===', line)
        end_match = re.match(r'^// === ([A-Z]+) ONLY END ===', line)

        if begin_match:
            in_block = True
            current_block_type = begin_match.group(1)
            modified_lines.append(line)
            continue
        elif end_match:
            in_block = False
            modified_lines.append(line)
            continue

        if in_block:
            if current_block_type == type:
                # Uncomment lines for blocks of the specified type
                if line.startswith('// '):
                    modified_lines.append(line[3:])
                else:
                    modified_lines.append(line)
            else:
                # Comment out lines for blocks of other types
                if not line.startswith('// '):
                    modified_lines.append('// ' + line)
                else:
                    modified_lines.append(line)
        else:
            modified_lines.append(line)

    with open(file_path, 'w', encoding='utf-8') as file:
        file.writelines(modified_lines)


def main(type=None):
    if type is None:
        try:
            import inquirer
        except ImportError:
            print("inquirer module is not installed. Please install it using 'pip install inquirer'")
            sys.exit(1)
        questions = [
            inquirer.List('type',
                          message="Select block type",
                          choices=hashers,
                         ),
        ]
        answers = inquirer.prompt(questions)
        type = answers['type']

    if type.upper() not in hashers:
        print(f"Invalid block type: {type}")
        sys.exit(1)
    current_directory = Path('src')
    for file_path in current_directory.rglob('*'):
        if file_path.is_file():
            process_file(file_path, type.upper())


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process files based on block type.")
    parser.add_argument('-t', '--type', type=str, help=f'Type of block to process {hashers}')
    args = parser.parse_args()

    if args.type:
        main(args.type)
    else:
        main()