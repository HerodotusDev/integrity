#!/bin/bash

os_type=$(uname -s)

if [ "$os_type" = "Linux" ]; then
    find ./src -type f | while read file; do
        sed -i '/\/\/ === KECCAK ONLY BEGIN ===/,/\/\/ === KECCAK ONLY END ===/ {
            /\/\/ === KECCAK ONLY BEGIN ===/! {
                /\/\/ === KECCAK ONLY END ===/! {
                    s/^/\/\/ /
                }
            }
        }' "$file"

        sed -i '/\/\/ === BLAKE ONLY BEGIN ===/,/\/\/ === BLAKE ONLY END ===/ {
            /\/\/ === BLAKE ONLY BEGIN ===/! {
                /\/\/ === BLAKE ONLY END ===/! {
                    s/^\/\/ //
                }
            }
        }' "$file"
    done
elif [ "$os_type" = "Darwin" ]; then
    find ./src -type f | while read file; do
        sed -i '' '/\/\/ === KECCAK ONLY BEGIN ===/,/\/\/ === KECCAK ONLY END ===/ {
            /\/\/ === KECCAK ONLY BEGIN ===/! {
                /\/\/ === KECCAK ONLY END ===/! {
                    s/^/\/\/ /
                }
            }
        }' "$file"

        sed -i '' '/\/\/ === BLAKE ONLY BEGIN ===/,/\/\/ === BLAKE ONLY END ===/ {
            /\/\/ === BLAKE ONLY BEGIN ===/! {
                /\/\/ === BLAKE ONLY END ===/! {
                    s/^\/\/ //
                }
            }
        }' "$file"
    done
else
    echo "Unsupported operating system: $os_type"
fi
