# Iterm2 Config file.

In order to load the settings, open iterm2 and
go to `Preferences / General / Load Preferences from a custom folder or URL / Browse`
and set the settings.

The whole thing is quite safe to use, since
    1) it is only used when explicitly stated in iterm2/Preferences/General/Load preferences from a custom folder or URL
    2) it is not taken into account on an Ubuntu platform, anyhow


Alternatively, you can also do it from the console,
but this has yet to be verified:

```bash
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
```
