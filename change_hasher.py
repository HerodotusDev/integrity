import argparse
import sys
from pathlib import Path
from utils import select_type, process_file

HASH_TYPES = ("KECCAK", "BLAKE")


def main(type=None):
    """Main function for processing files."""
    if type is None:
        type = select_type()

    if type.upper() not in HASH_TYPES:
        print(f"Invalid block type: {type}")
        sys.exit(1)

    current_directory = Path("src")
    for file_path in current_directory.rglob("*"):
        if file_path.is_file():
            process_file(file_path, type.upper())


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process files based on block type.")
    parser.add_argument(
        "-t", "--type", type=str, help=f"Type of block to process {HASH_TYPES}"
    )
    args = parser.parse_args()

    main(args.type)
