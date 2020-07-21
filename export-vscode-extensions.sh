#!/bin/bash
# Export the vscode extensions and write them to a file.
#
# author: andreasl

code --list-extensions > 'vscode-extensions.txt'
