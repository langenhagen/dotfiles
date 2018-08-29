# My personal fish config file for a mac machine
# author: andreasl
# version: 18-08-29

set fish_greeting "" # deactivates the fish welcome message

### my common environment variables ################################################################

setenv CODE_DIR ~/code
setenv SCRIPTS_DIR $CODE_DIR/scripts
setenv STUFF_DIR ~/stuff

### sourcing #######################################################################################

source ~/.iterm2_shell_integration.fish  # iterm2 shell integration

source ~/.config/fish/my-environment-variables.fish
source ~/.config/fish/my-functions.fish
source ~/.config/fish/my-abbreviations.fish

source ~/.config/fish/vimlike-bookmarks.fish

######### THE INITIAL COMMANDS #####################################################################

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

cd ~/code/sparta
