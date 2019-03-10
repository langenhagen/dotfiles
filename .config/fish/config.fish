# My personal fish config file.
# Should work on all platforms, including Mac OS with iterm2.
#
# author: andreasl

set fish_greeting "" # deactivates the fish welcome message

### sourcing #######################################################################################

source ~/.config/fish/environment-variables.fish
source ~/.config/fish/functions.fish
source ~/.config/fish/aliases.fish
source ~/.config/fish/abbreviations.fish

source ~/.config/fish/vimlike-bookmarks.fish

test -e $HOME/.iterm2_shell_integration.fish ; and source $HOME/.iterm2_shell_integration.fish
test -e $HOME/miniconda3/etc/fish/conf.d/conda.fish ; and source $HOME/miniconda3/etc/fish/conf.d/conda.fish

######### the initial commands #####################################################################

