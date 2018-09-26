import os
import sublime
import sublime_plugin
import subprocess

class CmdCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        ''' gets the directory path of the current text file and
            calls on an applescript app that opens the given directory in a new iTerm2 tab.
        '''
        file_name = self.view.file_name()
        path = file_name.split(os.sep)
        path.pop()
        current_directory = os.sep.join(path)
        # TODO somehow make the hard coded path not hardcoded
        # options:
        #  use environment variable
        #  put the OpenIterm2.app into a relative dir
        subprocess.call('open -a "$SCRIPTS_DIR_PATH/OpenIterm2.app" ' + current_directory, shell=True)
