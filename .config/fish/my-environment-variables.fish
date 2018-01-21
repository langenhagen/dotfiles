# My personal fish environment variables file for my Mac-workmachine
# author: langenhagen
# version: 18-01-21

# source this file into the config.fish

setenv JAVA_HOME "/Library/Java/JavaVirtualMachines/jdk1.8.0_141.jdk/Contents/Home"
setenv Z_SCRIPT_PATH /usr/local/etc/profile.d/z.sh
setenv ANDROID_HOME $HOME/Library/Android/sdk
setenv ANDROID_NDK_HOME $HOME/Library/Android/sdk/ndk-bundle
setenv SDK_ROOT $ANDROID_HOME
setenv NDK_ROOT $ANDROID_NDK_HOME
setenv OPENSSL_ROOT_DIR "/usr/local/Cellar/openssl/1.0.2h_1/"
setenv CCACHE_PREFIX icecc
setenv WORKSPACE "$HOME/code/sparta" # used for sparta CMake scripts to identify workspace

set -gx PATH $PATH /usr/local/sbin
set -gx PATH $PATH /usr/local/opt/icecream/libexec/icecc/bin
set -gx PATH $PATH $ANDROID_HOME/tools
set -gx PATH $PATH $ANDROID_HOME/platform-tools


setenv ANDROID_SERIAL CB5A286QVE            # that's my SONY XPeria Z5 Compact
#setenv ANDROID_SERIAL 024475e094d2743e      # that's the LG Nexus with PTM #245

