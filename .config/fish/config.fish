# My personal fish config file.
#
# Should work on all platforms, including Mac OS with iterm2.
#
# author: andreasl

set fish_greeting "" # deactivates the fish welcome message

### sourcing #######################################################################################

source ~/.config/fish/environment-variables.fish
source ~/.config/fish/key-bindings.fish
source ~/.config/fish/functions.fish
source ~/.config/fish/aliases.fish
source ~/.config/fish/abbreviations.fish

source ~/.config/fish/vimlike-bookmarks.fish

test -e $HOME/.iterm2_shell_integration.fish ; and source $HOME/.iterm2_shell_integration.fish
test -e $HOME/miniconda3/etc/fish/conf.d/conda.fish ; and source $HOME/miniconda3/etc/fish/conf.d/conda.fish

### bootstrapping ##################################################################################

# fisher, the fish package manager
# found here: https://github.com/jorgebucaran/fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# z
# found here: https://github.com/jethrokuan/z
if not functions -q z
    fisher add jethrokuan/z
end

### the initial commands ###########################################################################

