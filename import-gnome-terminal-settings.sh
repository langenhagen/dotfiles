#!/bin/bash
# Import gnome terminal settings from a dconf dump.
#
# author: andreasl

dconf load /org/gnome/terminal/legacy/profiles:/ < 'gnome-terminal-profiles.dconf'
