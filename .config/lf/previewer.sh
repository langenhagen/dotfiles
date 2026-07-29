#!/usr/bin/env bash
# As simple previewer I use in the cli file explorer `lf`.
#
# TODO: make coloring work correctly in lf.
#
# author: andreasl

# Debian ships `bat` under the name `batcat`, Homebrew under its real name
if command -v batcat >/dev/null; then
    batcat --color=always --style=numbers,changes,header "$1"
elif command -v bat >/dev/null; then
    bat --color=always --style=numbers,changes,header "$1"
else
    cat "$1"
fi
