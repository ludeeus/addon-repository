#!/bin/bash

python3 -m pip install --upgrade pip
find . -name requirements.txt -exec python3 -m pip install -r {} \;