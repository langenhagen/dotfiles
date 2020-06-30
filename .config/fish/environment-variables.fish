# My personal fish environment variables
#
# Source this file into the config.fish.
#
# author: andreasl

switch (uname -n)
    case "*barn-ultra*" "*celeraone*"
        setenv BUCKET_LIST_FILE_PATH "$HOME/Barn/Notes/bucket-list.txt"
        setenv CHECK_DIR_PATH "$HOME/Dev/check"
        setenv ONE_LINE_HELP_FILE_PATH "$HOME/Dev/Zeugs/one-line-help.txt"
        setenv PLAYGROUND_DIR_PATH "$HOME/Dev/_playgrounds"
        setenv PROTOFILES_DIR_PATH "$HOME/Dev/_Protofiles"
        setenv SCRIPTS_DIR_PATH "$HOME/Dev/scripts"
        setenv TRICKS_FILE_PATH "$HOME/Dev/Zeugs/tricks.sh"

    case "bee"
        setenv SCRIPTS_DIR_PATH "$HOME/scripts/generic-scripts"
end

switch (uname -n)
    case  "*celeraone*"

        set -gx JOURNAL_PATH "$HOME/Work/2018-2020-CeleraOne/journal.md"

        # Distcc Configuration
        # ====================

        # Remote servers used for compilation.
        setenv DISTCC_HOSTS '192.168.30.70/16,lzo 192.168.30.72/16,lzo'

        # Enable debug mode.
        # Useful when Distcc cannot connect to remote servers.
        # setenv DISTCC_VERBOSE 1


        # Integration Tests
        # =================

        # Path where engine binaries are stored.
        # The engine is stored or linked there deliberately.
        setenv C1_CRED_PREFIX /opt/c1/engine

        # Necessary for some of the c1-cre-api integration tests.
        setenv SETTING_OVERRIDES_MODE REDIS

        # Unit Testing, at least for Entitlement
        # ======================================

        setenv SERVERLAYERS false
        setenv ENGINE_MOCK true

        set -gx PATH $PATH "$HOME/c1/gitlab.celeraone.com/andreas.langenhagen/celeraone-scripts"

        setenv N_PREFIX "$HOME/n"
        set -gx PATH $PATH "$HOME/n/bin"
end

set -gx PATH $PATH '/usr/local/sbin'
set -gx PATH $PATH "$HOME/.pyenv/bin"
set -gx PATH $PATH "$HOME/.poetry/bin"
set -gx PATH $PATH "$HOME/.rbenv/bin"
set -gx PATH $PATH "$CHECK_DIR_PATH"
set -gx PATH $PATH "$SCRIPTS_DIR_PATH"

setenv LANG "en_US.UTF-8"
setenv EDITOR vim
setenv VISUAL vim

setenv PIP_REQUIRE_VIRTUALENV true
