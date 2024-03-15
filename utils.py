import re
import inquirer


def process_block(lines: list[str], type: str):
    """Processes a block of lines based on the given type."""
    in_block = False
    modified_lines = []

    for line in lines:
        begin_match = re.match(r"^// === ([A-Z]+) BEGIN ===", line)
        end_match = re.match(r"^// === ([A-Z]+) END ===", line)

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
                modified_lines.append(line[3:] if line.startswith("// ") else line)
            else:
                modified_lines.append(
                    "// " + line if not line.startswith("// ") else line
                )
        else:
            modified_lines.append(line)

    return modified_lines


def select_type(choices: list[str]) -> str | None:
    """Prompts the user to select a type."""
    questions = [inquirer.List("type", message="Select block type", choices=choices)]
    answers = inquirer.prompt(questions)
    return answers["type"]


def read_file(file_path: str) -> list[str]:
    """Reads a file and returns its content as a list of lines."""
    try:
        with open(file_path, "r", encoding="utf-8") as file:
            return file.readlines()
    except UnicodeDecodeError:
        print(f"Skipping file due to encoding issue: {file_path}")
        return []


def process_file(file_path, type) -> None:
    """Processes a file based on the given type."""
    lines = read_file(file_path)
    if not lines:
        return

    modified_lines = process_block(lines, type)

    with open(file_path, "w", encoding="utf-8") as file:
        file.writelines(modified_lines)
