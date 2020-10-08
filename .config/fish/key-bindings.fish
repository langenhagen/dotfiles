# My personal fish environment variables.
#
# Source this file into the config.fish.
# Use the tool fish_key_reader to evaluate key names.
#
# author: andreasl

function fish_user_key_bindings
    # Predefined fish <v3.0 function to override personal key bindings.

    # as a safety feature, press ctrl+d quickly 2 times exit fish
    bind \cd delete-char
    bind \cd\cd exit

    bind \e\[1\;3D backward-bigword
    bind \e\[1\;3C forward-bigword

    # cd to directories or open files with vim with ctrl + e
    bind \ce 'set fzf_sel (fzf); [ -d "$fzf_sel" ]; and cd "$fzf_sel"; [ -f "$fzf_sel" ]; and vim -p "$fzf_sel"; commandline -f repaint;'
end
