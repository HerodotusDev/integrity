import re


def process_block(lines: list[str], types: list[str]):
    """Processes a block of lines based on the given types."""
    in_block = False
    modified_lines = []

    for line in lines:
        begin_match = re.match(r"^(\s*)// === ([A-Z_0-9]+) BEGIN ===", line)
        end_match = re.match(r"^(\s*)// === ([A-Z_0-9]+) END ===", line)

        if begin_match:
            in_block = True
            indent = begin_match.group(1)
            current_block_type = begin_match.group(2)
            modified_lines.append(line)
            continue
        elif end_match:
            in_block = False
            modified_lines.append(line)
            continue

        if in_block and line.strip() != "":
            if current_block_type in types:
                # Remove comment if exists
                if line.lstrip().startswith("// "):
                    modified_lines.append(indent + line.lstrip()[3:])
                else:
                    modified_lines.append(line)
            else:
                # Add comment if does not exist
                if not line.lstrip().startswith("// "):
                    line_indent = len(line) - len(line.lstrip())
                    subtracted_indent = min(len(indent), line_indent)
                    modified_lines.append(indent + "// " + line[subtracted_indent:])
                else:
                    modified_lines.append(line)
        else:
            modified_lines.append(line)

    return modified_lines


def read_file(file_path: str) -> list[str]:
    """Reads a file and returns its content as a list of lines."""
    try:
        with open(file_path, "r", encoding="utf-8") as file:
            return file.readlines()
    except UnicodeDecodeError:
        print(f"Skipping file due to encoding issue: {file_path}")
        return []


def process_file(file_path, types: list[str]) -> None:
    """Processes a file based on the given types."""
    lines = read_file(file_path)
    if not lines:
        return

    modified_lines = process_block(lines, types)

    with open(file_path, "w", encoding="utf-8") as file:
        file.writelines(modified_lines)
