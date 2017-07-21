# Iterm2 Config file.

In order to load the settings, open iterm2 and
go to `Preferences / General / Load Preferences from a custom folder or URL / Browse`
and set the settings.


Alternatively, you can also do it from the console,
but this has yet to be verified:

```bash
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
```