#!/bin/bash
# As simple previewer I use in the cli file explorer `lf`.
#
# TODO: make coloring work correctly in lf.
#
# author: andreasl

unset COLORTERM

command -v batcat && batcat --color=auto --style='numbers,changes,header' "$1" && exit 0
cat "$1"
