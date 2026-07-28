#!/usr/bin/env bash
# Install the vscode extensions.
#
# author: andreasl

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

while IFS= read -r extension; do
    code --install-extension "$extension"
done <"${script_dir}/vscode-extensions.txt"
