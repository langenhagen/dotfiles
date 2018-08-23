# My personal fish environment variables file for my Mac-workmachine
# author: andreasl
# version: 18-04-13

# source this file into the config.fish

set -gx PATH $PATH /usr/local/sbin

setenv JAVA_HOME "/Library/Java/JavaVirtualMachines/jdk1.8.0_141.jdk/Contents/Home"
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
set -gx PATH $PATH "/Users/langenha/code/scripts"
#setenv ANDROID_SERIAL 024475e094d2743e      # that's the LG Nexus with PTM #245
setenv ANDROID_SERIAL H6AKCV0015736RJ      # that's the ASUS Tango


setenv OPENSSL_ROOT_DIR "/usr/local/Cellar/openssl/1.0.2h_1/"
setenv WORKSPACE "$HOME/code/sparta" # used for sparta CMake scripts to identify workspace

# ccache memcached settings - for ivi-mobile-frameworks/apigen team shared build cache
set -gx CCACHE_MEMCACHED_CONF "--SERVER=apigen-memcached.ad.here.com"
set -gx CCACHE_BASEDIR "/Users/langenha/code/sparta"
#setenv CCACHE_PREFIX icecc
#set -gx PATH $PATH /usr/local/opt/icecream/libexec/icecc/bin
