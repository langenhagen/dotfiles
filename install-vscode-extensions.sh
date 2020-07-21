#!/bin/bash
# Install the vscode extensions.
#
# author: andreasl

mapfile -t extensions <<< "$(cat 'vscode-extensions.txt')"

for extension in "${extensions[@]}"; do
    code --install-extension "$extension"
done
