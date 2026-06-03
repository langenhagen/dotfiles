# Dotfiles
author: andreasl

A bunch of .dotfiles and .dotfolders to configure your UNIX environment.
It may also contain exported settings from other programs.

The project is structured as follows:
```
.
├── README.md                           You are here now.
├── assume_unchanged.sh                 Tell git to ignore local config changes.
├── export-gnome-terminal-settings.sh   Export GNOME terminal profiles to file.
├── export-vscode-extensions.sh         Export installed VS Code extensions to file.
├── import-gnome-terminal-settings.sh   Import GNOME terminal profiles from file.
├── install-vscode-extensions.sh        Install VS Code extensions from file.
├── link-files.sh                       Main utility to link the dotfiles.
└── ...                                 Dotfiles and config files and directories.
```


## Installation
Clone the git repository and then call the script `link-files.sh` to link the dotfiles
into your system with `ln -s`:

```bash
git clone https://github.com/langenhagen/dotfiles.git
cd dotfiles
git pull origin master
./link-files.sh
```

Running `link-files.sh` will use `ln -sf` to create symlinks, overwriting any existing files or
symlinks at the target paths, or even call `rm` on files

There are other scripts in the root folder of the repository. Consider running them, too.


## Making changes
You can configure the dotfiles simply via the paths symlinked into your home directory.
When you add new files or want to remove dotfiles, please don't add them directly into
your system, but into the `dotfiles` folder, change the `link-files.sh` accordingly and
then run `link-files.sh`. Restart the concerning programs to see the changes take effect.

### Opt-In Philosophy
The dotfiles generally link files rather than folders into the system. This happens in order to
allow for custom machine-specific configurations that may not land in the dotfiles.
Exceptions may exist.

## Checking out other versions
When you do something like `git checkout mybranch`, links to the dotfiles created with `ln -s`,
especially links created by calling `link-files.sh` will follow the old file versions that
were in place before the checkout. Call `link-files.sh` again to make changes due to git
checkouts take effect.


## Contributing
Work on your stuff locally, branch, commit and modify to your heart's content.
As soon as you are ready, do:

```bash
git push origin HEAD:master
```

Happy coding!
