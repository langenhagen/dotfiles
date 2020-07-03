#!/bin/bash

unset COLORTERM
# vim --cmd 'set t_ti= t_te=' +redraw +q "$1"

command -v batcat && batcat --color=always --style='numbers,changes,header' "$1" && exit 0
cat "$1"