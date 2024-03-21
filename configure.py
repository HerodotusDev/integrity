import argparse
import sys
import inquirer
from pathlib import Path
from utils import process_file

LAYOUT_TYPES = ("dex", "recursive", "recursive_with_poseidon", "small", "starknet", "starknet_with_keccak")
HASH_TYPES = ("keccak", "blake")


def select_types() -> str:
    """Prompts the user to select a type."""
    questions = [
        inquirer.List("layout_type", message="Select layout", choices=LAYOUT_TYPES),
        inquirer.List("hash_type", message="Select hash", choices=HASH_TYPES),
    ]
    answers = inquirer.prompt(questions)
    return (answers["layout_type"], answers["hash_type"])


def main(layout_type=None, hash_type=None):
    """Main function for processing files."""
    if layout_type is None or hash_type is None:
        layout_type, hash_type = select_types()

    if layout_type.lower() not in LAYOUT_TYPES:
        print(f"Invalid layout type: {layout_type}")
        sys.exit(1)

    if hash_type.lower() not in HASH_TYPES:
        print(f"Invalid hash type: {hash_type}")
        sys.exit(1)

    current_directory = Path("src")
    for file_path in current_directory.rglob("*.cairo"):
        if file_path.is_file():
            process_file(file_path, [layout_type.upper(), hash_type.upper()])


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process files based on block type.")
    parser.add_argument(
        "-l", "--layout_type", type=str, help=f"Type of layouts {LAYOUT_TYPES}"
    )
    parser.add_argument(
        "-s", "--hash_type", type=str, help=f"Type of hashes {HASH_TYPES}"
    )
    args = parser.parse_args()

    main(args.layout_type, args.hash_type)
