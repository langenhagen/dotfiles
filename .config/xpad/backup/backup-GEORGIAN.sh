#!/bin/bash
#
# Backup the content of the xpad file "content-GEORGIAN".
#
# author: andreasl

backup_file="$HOME/Barn/Notes/Georgian.txt"
cat "$HOME/.config/xpad/content-GEORGIAN" >> "$backup_file"
sort --ignore-case --output="$backup_file" --unique "$backup_file"
