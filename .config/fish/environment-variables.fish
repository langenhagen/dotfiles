# My, Andreas Langenhagen's, fish environment variables.
#
# Source this file into the config.fish.
#
# author: andreasl

switch (uname -n)
    case "*barn-ultra*" "*work*"
        setenv BUCKET_LIST_FILE_PATH "$HOME/Barn/Notes/bucket-list.txt"
        setenv CHECK_DIR_PATH "$HOME/Dev/check"
        setenv ONE_LINE_HELP_FILE_PATH "$HOME/Dev/Zeugs/one-line-help.txt"
        setenv PROTOFILES_DIR_PATH "$HOME/Dev/protofiles"
        setenv SCRIPTS_DIR_PATH "$HOME/Dev/scripts"
        setenv TRICKS_FILE_PATH "$HOME/Dev/Zeugs/tricks.sh"

    case "bee"
        setenv CHECK_DIR_PATH "$HOME/scripts/check"
        setenv SCRIPTS_DIR_PATH "$HOME/scripts/generic-scripts"
end

switch (uname -n)
    case  "*work*"
        set -gx JOURNAL_PATH "$HOME/Work/2021-Micropsi/journal.md"
        set -gx PATH "$HOME/Dev/micropsi-scripts" $PATH
end

set -gx PATH "$HOME/go/bin" $PATH
set -gx PATH "$HOME/.rbenv/bin" $PATH
set -gx PATH "$HOME/.pyenv/bin" $PATH
set -gx PATH "$HOME/.pyenv/shims" $PATH
set -gx PATH "$CHECK_DIR_PATH" $PATH
set -gx PATH "$SCRIPTS_DIR_PATH" $PATH

setenv LANG 'en_US.UTF-8'
setenv EDITOR vim
setenv VISUAL vim

setenv N_PREFIX "$HOME/n"  # remove after you run only Ubuntu >=20

setenv PIP_REQUIRE_VIRTUALENV true

setenv FZF_DEFAULT_COMMAND "find -L . \( -path '*/.git' -o -path '*/.venv' \) -prune -o -print"
setenv FZF_DEFAULT_OPTS '--bind ctrl-d:page-down,ctrl-u:page-up'
if command -v batcat >/dev/null
    setenv FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --preview 'batcat --color=always --style=header,numbers {} 2>/dev/null || tree -Ca {} 2>/dev/null'"
else
    setenv FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --preview 'cat {}'"
end
