#!/bin/bash
set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 DEST_DIR" >&2
    exit 1
fi

DEST="$1"

FILE_LIST=("run_setup.sh" "pyproject.toml" "setup.cfg" "LICENSE" "README.md" ".gitignore")
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1 && pwd)"

mkdir -p "$DEST"
for file in "${FILE_LIST[@]}"; do
    if [ -e "$SRC_DIR/$file" ]; then
        cp "$SRC_DIR/$file" "$DEST/"
    else
        echo "Warning: $file does not exist in source directory." >&2
    fi
done