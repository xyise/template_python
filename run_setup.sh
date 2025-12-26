#!/bin/bash
PYTHON_BIN="python3.11"
VENV_DIR="venv"

if [ "$#" -eq 0 ]; then
    echo "'clean' or 'update' is required."
    echo "'clean': remove existing venv and create a new one."
    echo "'update': update existing venv."
    exit 1
fi

if [ "$1" = "clean" ]; then
    mkdir -p src
    echo "Removing and creating a new virtual environment..."
    rm -rf "${VENV_DIR}"
    "${PYTHON_BIN}" -m venv "${VENV_DIR}"
    # shellcheck source=/dev/null
    source "${VENV_DIR}/bin/activate"
    pip install --upgrade pip setuptools wheel
    pip install -e .
    pip install -e ".[dev]"

elif [ "$1" = "update" ]; then

    if [ -z "${VIRTUAL_ENV}" ] || [ "${VIRTUAL_ENV}" != "$(pwd)/${VENV_DIR}" ]; then
        echo "Activate the virtual environment before updating."
        exit 1
    fi

    pip install -e .
    pip install -e ".[dev]"

else
    echo "Unknown command: $1"
    echo "'clean' or 'update' is required."
    exit 1
fi