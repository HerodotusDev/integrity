#!/bin/bash

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
