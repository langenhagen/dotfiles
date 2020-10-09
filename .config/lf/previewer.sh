#!/bin/bash
# As simple previewer I use in the cli file explorer `lf`.
#
# TODO: make coloring work correctly in lf.
#
# author: andreasl

command -v batcat && { batcat --color=always --style=numbers,changes,header "$1"; } || cat "$1"
