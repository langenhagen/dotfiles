# This file contains custom fish aliases.
#
# Aliases in fish play together with abbreviations.
# Fish aliases interact well with already defined aliases.
#
# author: andreasl

alias grep 'grep --color --exclude-dir=".git" --exclude-dir=".ipynb_checkpoints" --exclude-dir="__pycache__"'
# On macOS the *h abbrs call ggrep directly, because bsdgrep ignores symlinks
# even with -R. Mirror the grep alias so they behave the same otherwise.
if test (uname) = 'Darwin'
    alias ggrep 'ggrep --color --exclude-dir=".git" --exclude-dir=".ipynb_checkpoints" --exclude-dir="__pycache__"'
end

alias less 'less --ignore-case'  # less with smart (sic!) case
