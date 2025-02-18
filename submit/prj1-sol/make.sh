#!/bin/sh

#!/bin/bash

# Ensure the script stops if any command fails
set -e

# Ensure Python 3 is installed
if ! command -v python3 &> /dev/null
then
    echo "Python 3 could not be found. Please install it."
    exit 1
fi

# Install dependencies (if needed)
pip3 install --user --upgrade json

echo "Build complete. You can now run the project using run.sh."


