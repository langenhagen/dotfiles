#!/bin/bash
# Set git to assume files in an array to be unchanged,
# or, if the flag `-no` is passed, set git not to assume that files in an array are unchanged.
#
# Change the array to your likings.
#
# author: andreasl

files=(
    '.config/sublime-text-3/Packages/User/Preferences.sublime-settings'
    '.config/konsolerc')

if [ "$1" == '-no' ]; then
    for file in ${files[@]} ; do
        git update-index --no-assume-unchanged ${file}
    done
else
    for file in ${files[@]} ; do
        git update-index --assume-unchanged ${file}  # ignore further changes to a file
    done
fi
