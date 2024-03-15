import argparse
import sys
from pathlib import Path
from utils import select_type, process_file

LAYOUT_TYPES = ("DEX", "RECURSIVE", "RECURSIVE_WITH_POSEIDON", "SMALL", "STARKNET")


def main(type=None):
    """Main function for processing files."""
    if type is None:
        type = select_type()

    if type.upper() not in LAYOUT_TYPES:
        print(f"Invalid block type: {type}")
        sys.exit(1)

    current_directory = Path("src")
    for file_path in current_directory.rglob("*"):
        if file_path.is_file():
            process_file(file_path, type.upper())


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process files based on block type.")
    parser.add_argument(
        "-t", "--type", type=str, help=f"Type of block to process {LAYOUT_TYPES}"
    )
    args = parser.parse_args()

    main(args.type)
