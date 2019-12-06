# My personal fish environment variables.
#
# Source this file into the config.fish.
#
# author: andreasl

function fish_user_key_bindings
    # Predefined fish <v3.0 function to override personal key bindings.

    # as a safety feature, press ctrl+d quickly 2 times exit fish
    bind \cd delete-char
    bind \cd\cd exit
end
