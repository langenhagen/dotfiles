# My personal fish config file.
# Should work on all platforms, including Mac OS with iterm2.
# author: andreasl
# version: 18-09-27

set fish_greeting "" # deactivates the fish welcome message

### sourcing #######################################################################################

source ~/.config/fish/my-environment-variables.fish
source ~/.config/fish/my-functions.fish
source ~/.config/fish/my-abbreviations.fish

source ~/.config/fish/vimlike-bookmarks.fish

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish # iterm2 shell integration

######### the initial commands #####################################################################

cd ~
