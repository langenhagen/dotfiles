# My, Andreas Langenhagen's, fish environment variables.
#
# Source this file into the config.fish.
#
# author: andreasl

switch (uname -n)
    case "*barn-ultra*" "*work*"
        set -x BUCKET_LIST_FILE_PATH "$HOME/Barn/Notes/bucket-list.txt"
        set -x CHECK_DIR_PATH "$HOME/Dev/check"
        set -x ONE_LINE_HELP_FILE_PATH "$HOME/Dev/Zeugs/one-line-help.txt"
        set -x PROTOFILES_DIR_PATH "$HOME/Dev/protofiles"
        set -x SCRIPTS_DIR_PATH "$HOME/Dev/scripts"
        set -x TRICKS_FILE_PATH "$HOME/Dev/Zeugs/tricks.sh"

    case "bee"
        set -x CHECK_DIR_PATH "$HOME/scripts/check"
        set -x SCRIPTS_DIR_PATH "$HOME/scripts/generic-scripts"
end

switch (uname -n)
    case  "*work*"
        set -gx JOURNAL_PATH "$HOME/Work/2024-Wandelbots/journal.md"
        set -gx PATH "$HOME/Dev/wandelbots-scripts/" $PATH
end

set -gx PATH "$HOME/go/bin" $PATH
set -gx PATH "$HOME/.rbenv/bin" $PATH
set -gx PATH "$HOME/.pyenv/bin" $PATH
set -gx PATH "$HOME/.pyenv/shims" $PATH
set -gx PATH '/usr/libexec/docker/cli-plugins/' $PATH
set -gx PATH "$CHECK_DIR_PATH" $PATH
set -gx PATH "$SCRIPTS_DIR_PATH" $PATH
set -gx PATH "$HOME/.local/bin" $PATH

set -x LANG 'en_US.UTF-8'
set -x EDITOR vim
set -x VISUAL vim

set -x PIP_REQUIRE_VIRTUALENV true

set -x FZF_DEFAULT_COMMAND "find -L . \( -path '*/.git' -o -path '*/.venv' \) -prune -o -print"
set -x FZF_DEFAULT_OPTS '--bind ctrl-d:page-down,ctrl-u:page-up'
if command -v batcat >/dev/null
    set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --preview 'batcat --color=always --style=header,numbers {} 2>/dev/null || tree -Ca {} 2>/dev/null'"
else
    set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --preview 'cat {}'"
end
