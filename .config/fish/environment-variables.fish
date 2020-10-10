# My personal fish environment variables
#
# Source this file into the config.fish.
#
# author: andreasl

switch (uname -n)
    case "*barn-ultra*" "*momox*"
        setenv BUCKET_LIST_FILE_PATH "$HOME/Barn/Notes/bucket-list.txt"
        setenv CHECK_DIR_PATH "$HOME/Dev/check"
        setenv ONE_LINE_HELP_FILE_PATH "$HOME/Dev/Zeugs/one-line-help.txt"
        setenv PLAYGROUND_DIR_PATH "$HOME/Dev/_playgrounds"
        setenv PROTOFILES_DIR_PATH "$HOME/Dev/_protofiles"
        setenv SCRIPTS_DIR_PATH "$HOME/Dev/scripts"
        setenv TRICKS_FILE_PATH "$HOME/Dev/Zeugs/tricks.sh"

    case "bee"
        setenv SCRIPTS_DIR_PATH "$HOME/scripts/generic-scripts"
end

switch (uname -n)
    case  "*momox*"
        set -gx JOURNAL_PATH "$HOME/Work/2020-Momox/journal.md"

        set -gx PATH $PATH "$HOME/momox/gitlab.bof.mm.local/alangenhagen/momox-scripts"
end

set -gx PATH $PATH '/usr/local/sbin'
set -gx PATH $PATH "$HOME/go/bin"
set -gx PATH $PATH "$HOME/.cargo/bin"
set -gx PATH $PATH "$HOME/.poetry/bin"
set -gx PATH $PATH "$HOME/.rbenv/bin"
set -gx PATH $PATH "$HOME/.pyenv/bin"
setenv N_PREFIX "$HOME/n"
set -gx PATH $PATH "$HOME/n/bin"
set -gx PATH $PATH "$CHECK_DIR_PATH"
set -gx PATH $PATH "$SCRIPTS_DIR_PATH"

setenv LANG "en_US.UTF-8"
setenv EDITOR vim
setenv VISUAL vim

setenv PIP_REQUIRE_VIRTUALENV true

setenv FZF_DEFAULT_COMMAND "find -L . \( -path '*/.git' -o -path '*/.venv' \) -prune -o -print"
setenv FZF_DEFAULT_OPTS '--bind ctrl-d:page-down,ctrl-u:page-up'
if command -v batcat >/dev/null
    setenv FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --preview 'batcat --color=always --style=header,numbers {} 2>/dev/null || tree -Ca {} 2>/dev/null'"
else
    setenv FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --preview 'cat {}'"
end
