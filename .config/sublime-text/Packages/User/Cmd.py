import os
import sublime
import sublime_plugin
import subprocess
import sys

class CmdCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        ''' Gets the directory path of the current text file and, depending on the platform,
            either, if on Linux, opens Gnome's Terminal
            or, if on Mac, calls an applescript that opens the given directory in a new iTerm2 tab.
        '''
        file_name = self.view.file_name()
        path = file_name.split(os.sep)
        path.pop()
        current_directory = os.sep.join(path)

        if sys.platform == 'linux':
            subprocess.call('gnome-terminal --working-directory ' + current_directory + '&', shell=True)
        elif sys.platform == 'darwin':
            subprocess.call('open -a "$SCRIPTS_DIR_PATH/OpenIterm2.app" ' + current_directory, shell=True)
        else:
            pass
