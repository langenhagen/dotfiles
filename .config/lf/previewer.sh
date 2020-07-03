#!/bin/bash
# As simple previewer I use in the cli file explorer `lf`.
#
# author: andreasl

unset COLORTERM

command -v batcat && batcat --color=always --style='numbers,changes,header' "$1" && exit 0
cat "$1"
