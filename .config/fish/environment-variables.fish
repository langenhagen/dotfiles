# My personal fish environment variables
#
# Source this file into the config.fish.
#
# author: andreasl

switch (uname -n)
    case "*barn-ultra*" "*celeraone*"
        setenv BUCKET_LIST_FILE_PATH "$HOME/Barn/Notes/bucket-list.txt"
        setenv JOURNAL_FILE_PATH "$HOME/Barn/Notes/Journal.txt"
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
        # Distcc Configuration
        # ====================

        # Enable local cache to use Distcc.
        setenv CCACHE_PREFIX distcc

        # Remote servers used for compilation.
        setenv DISTCC_HOSTS "192.168.30.70/16,lzo --localslots/4"

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

        set -gx PATH $PATH "$HOME/Dev/celeraone/scripts"
end

set -gx PATH $PATH '/usr/local/sbin'
setenv N_PREFIX "$HOME/n"
set -gx PATH "$HOME/n/bin" $PATH
set -gx PATH $PATH "$SCRIPTS_DIR_PATH"

setenv LANG "en_US.UTF-8"
setenv EDITOR vim
setenv VISUAL vim
