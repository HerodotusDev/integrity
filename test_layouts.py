import subprocess
import argparse
from colorama import Fore, Style


# Function to execute commands and log the process
def log_and_run(commands, description, cwd=None):
    full_command = " && ".join(commands)

    try:
        print(f"{Fore.YELLOW}Starting: {description}...{Style.RESET_ALL}")
        print(f"{Fore.CYAN}Command: {full_command}{Style.RESET_ALL}")

        # Execute the command
        result = subprocess.run(
            full_command, shell=True, check=True, cwd=cwd, text=True
        )

        print(f"{Fore.GREEN}Success: {description} completed!\n{Style.RESET_ALL}")
    except subprocess.CalledProcessError as e:
        print(
            f"{Fore.RED}Error running command '{full_command}': {e}\n{Style.RESET_ALL}"
        )


# List of layouts to test
LAYOUTS = ["DEX", "RECURSIVE", "RECURSIVE_WITH_POSEIDON", "SMALL"]


# Main function to run the tests and optionally restore the src folder
def main(restore_src=None):
    for layout in LAYOUTS:
        log_and_run(
            [
                f"python configure.py -l {layout} -s KECCAK",
                "scarb build",
                f"cargo run --release --bin runner -- target/dev/cairo_verifier.sierra.json < examples/proofs/{layout.lower()}/example_proof.json",
            ],
            f"Testing {layout.lower()} layout",
            cwd=".",
        )

    # Check if src folder restoration is required
    if restore_src is None:
        response = input("Do you want to restore the src folder? (y/n): ")
        restore_src = response.lower() == "y"

    # Restore the src folder if requested
    if restore_src:
        log_and_run(["git restore src/"], "Restoring src folder", cwd=".")


# Entry point of the script
if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Test cairo1-verifier layouts on example proofs"
    )

    # Define command-line arguments
    parser.add_argument(
        "-r", "--restore-src", action="store_true", help="Restore src folder after run"
    )

    # Parse the arguments
    args = parser.parse_args()

    # Run main function with the specified arguments
    main(args.restore_src)
