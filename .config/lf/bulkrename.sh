#!/bin/bash
# A bulkrename feature similare to the bulkrename feature in `ranger`.
#
# Based on: https://github.com/NullSense/dots/blob/master/.config/lf/bulkrename.sh
#
# author: andreasl

rename_file="$(mktemp)"
marked_files=()
for marked_file in $@; do
    marked_files+=("$marked_file")
    name=$(basename -- "$marked_file")
    printf "$name\n" >> "$rename_file"
done
"${EDITOR:-vi}" "$rename_file"

IFS=$'\n' read -d "" -ra changed_files < "$rename_file"
((${#marked_files[@]} != ${#changed_files[@]})) && {
    rm "$rename_file"
    exit 1
}

printf '%s\n%s\n' \
    '# This file will be executed when the editor is closed.' \
    '# Clear the file to abort.' > "$rename_file"

renamed=0
for ((i = 0; i < ${#marked_files[@]}; i++)) {
    if [ "${marked_files[i]}" != "${PWD}/${changed_files[i]}" ]; then
        printf 'mv -i -- %q %q\n' "${marked_files[i]}" "${PWD}/${changed_files[i]}"
        renamed=1
    fi
} >> "$rename_file"

((renamed == 1)) && {
    "${EDITOR:-vi}" "$rename_file"

    source "$rename_file"
    rm "$rename_file"
}
