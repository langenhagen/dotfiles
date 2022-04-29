# My, andreasl's, fish config file.
# Should work on Linux and Mac OS with iterm2.

set fish_greeting ""  # deactivate the fish welcome message

### sourcing #######################################################################################

source ~/.config/fish/environment-variables.fish
source ~/.config/fish/key-bindings.fish
source ~/.config/fish/functions.fish
source ~/.config/fish/aliases.fish
source ~/.config/fish/abbreviations.fish

source ~/.config/fish/vimlike-bookmarks.fish

test -e ~/.iterm2_shell_integration.fish; and source ~/.iterm2_shell_integration.fish
test -e ~/miniconda3/etc/fish/conf.d/conda.fish; and source ~/miniconda3/etc/fish/conf.d/conda.fish
test -e ~/.rbenv/bin/rbenv; and status --is-interactive; and source (~/.rbenv/bin/rbenv init - | psub)

command -v pyenv 1>/dev/null 2>&1; and pyenv init - | source
command -v direnv 1>/dev/null 2>&1; and eval (direnv hook fish)
nvm --version 1>/dev/null 2>&1; and nvm use lts 1>/dev/null

### the initial commands ###########################################################################
