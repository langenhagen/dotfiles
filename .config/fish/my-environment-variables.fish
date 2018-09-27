# My personal fish environment variables file for my Mac-workmachine
# author: andreasl
# version: 18-09-26

# source this file into the config.fish

set -gx PATH $PATH /usr/local/sbin

if [ (uname -n) = "4demlangenha.ad.here.com" ]

    setenv TRICKS_FILE_PATH "$HOME/personal/Dev/Zeugs/tricks.txt"
    setenv ONE_LINE_HELP_FILE_PATH "$HOME/personal/Dev/Zeugs/one-line-help.txt"
    setenv BUCKET_LIST_FILE_PATH "$HOME/personal/Barn/Notes/bucket-list.txt"
    setenv JOURNAL_FILE_PATH "$HOME/personal/Barn/Notes/Journal.txt"
    setenv PROTOFILES_DIR_PATH "$HOME/personal/Dev/_Protofiles"
    setenv PLAYGROUND_DIR_PATH "$HOME/personal/Dev/_playgrounds"

    setenv SCRIPTS_DIR_PATH "$HOME/personal/Dev/scripts"  # used e.g. by my Sublime Text's CMD command

    setenv JAVA_HOME '/Library/Java/JavaVirtualMachines/jdk1.8.0_141.jdk/Contents/Home'

    # The following variable Z_SCRIPT_PATH must actually be set before sourcing .config/fish/conf.d/omf.fish
    # I set it directly inside the omf.fish file at the top. That seems to work :)
    # I still let it here for doc purposes for now.  Feel free to remove :)
    setenv Z_SCRIPT_PATH /usr/local/etc/profile.d/z.sh

    setenv ANDROID_HOME $HOME/Library/Android/sdk
    setenv ANDROID_NDK_HOME $HOME/Library/Android/sdk/ndk-bundle
    setenv SDK_ROOT $ANDROID_HOME
    setenv NDK_ROOT $ANDROID_NDK_HOME
    set -gx PATH $PATH $ANDROID_HOME/tools
    set -gx PATH $PATH $ANDROID_HOME/platform-tools
    set -gx PATH $PATH '$HOME/personal/Dev/scripts'

    setenv OPENSSL_ROOT_DIR '/usr/local/Cellar/openssl/1.0.2h_1/'

    #setenv CCACHE_PREFIX icecc
    #set -gx PATH /usr/local/opt/icecream/libexec/icecc/bin $PATH

else if [ (uname -n) = "barn-ultra" ]

    setenv TRICKS_FILE_PATH "$HOME/Dev/Zeugs/tricks.txt"
    setenv ONE_LINE_HELP_FILE_PATH "$HOME/Dev/Zeugs/one-line-help.txt"
    setenv BUCKET_LIST_FILE_PATH "$HOME/Barn/Notes/bucket-list.txt"
    setenv JOURNAL_FILE_PATH "$HOME/Barn/Notes/Journal.txt"
    setenv PROTOFILES_DIR_PATH "$HOME/Dev/_Protofiles"
    setenv PLAYGROUND_DIR_PATH "$HOME/Dev/_playgrounds"

    setenv SCRIPTS_DIR_PATH "$HOME/Dev/scripts"

end





