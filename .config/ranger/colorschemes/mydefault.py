# author: andreasl
#
# Because I want to increase the selected file/folder background/foreground contrast.
#
# explanation found here:
# https://github.com/ranger/ranger/blob/master/doc/colorschemes.md
#
# based on:
# https://github.com/ranger/ranger/blob/325f41e6a841ab1413020b9d2d86c3922d90f407/ranger/colorschemes/jungle.py

from __future__ import (absolute_import, division, print_function)

from ranger.colorschemes.default import Default
from ranger.gui.color import green, red, blue

class Scheme(Default):
    progress_bar_color = green

    def use(self, context):
        fg, bg, attr = Default.use(self, context)

        if context.directory and not context.marked and not context.link \
                and not context.inactive_pane:
            fg = green

        if context.in_titlebar and context.hostname:
            fg = red if context.bad else blue

        return fg, bg, attr