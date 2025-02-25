#!/bin/sh

#!/bin/bash

set -e

if ! command -v python3 &> /dev/null
then
    echo "Python 3 could not be found. Please install it."
    exit 1
fi

pip3 install --user --upgrade json

echo "Build complete. You can now run the project using run.sh."


