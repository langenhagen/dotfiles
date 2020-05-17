#!/bin/bash
# Export gnome terminal settings to a dconf dump.
#
# author: andreasl

dconf dump /org/gnome/terminal/legacy/profiles:/ > 'gnome-terminal-profiles.dconf'
