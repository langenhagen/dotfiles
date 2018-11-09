import datetime, getpass
import sublime, sublime_plugin
class AddAuthorAndVersionCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        self.view.run_command("insert_snippet", { "contents": "# author: andreasl\n# version: %s" %  datetime.date.today().strftime("%y-%m-%d")
 } )