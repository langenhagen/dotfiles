# My personal fish config file for a mac machine
# author: langenhagen
# version: 17-11-27

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



######### THE INITIAL COMMANDS #####################################################################

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

cd ~/code/sparta
