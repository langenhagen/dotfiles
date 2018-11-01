# My personal fish environment variables
# author: andreasl
# version: 18-09-26

# source this file into the config.fish

set -gx PATH $PATH /usr/local/sbin

switch (uname -n)
    case "*barn-ultra*" "*celeraone*"

        setenv TRICKS_FILE_PATH "$HOME/Dev/Zeugs/tricks.txt"
        setenv ONE_LINE_HELP_FILE_PATH "$HOME/Dev/Zeugs/one-line-help.txt"
        setenv BUCKET_LIST_FILE_PATH "$HOME/Barn/Notes/bucket-list.txt"
        setenv JOURNAL_FILE_PATH "$HOME/Barn/Notes/Journal.txt"
        setenv PROTOFILES_DIR_PATH "$HOME/Dev/_Protofiles"
        setenv PLAYGROUND_DIR_PATH "$HOME/Dev/_playgrounds"

        setenv SCRIPTS_DIR_PATH "$HOME/Dev/scripts"
end

setenv LANG "en_US.UTF-8"

set -gx PATH $PATH "$SCRIPTS_DIR_PATH"



