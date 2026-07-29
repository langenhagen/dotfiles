# Dotfiles
author: andreasl

A bunch of .dotfiles and .dotfolders to configure my Linux/macOS environments.
It may also contain exported settings from other programs.

The project is structured as follows:
```
.
├── README.md                           You are here now.
├── assume_unchanged.sh                 Tell git to ignore local config changes.
├── export-gnome-terminal-settings.sh   Export GNOME terminal profiles to file. Linux only.
├── export-vscode-extensions.sh         Export installed VS Code extensions to file.
├── import-gnome-terminal-settings.sh   Import GNOME terminal profiles from file. Linux only.
├── install-vscode-extensions.sh        Install VS Code extensions from file.
├── link-files-linux.sh                 Main utility to link the dotfiles on Linux.
├── link-files-macos.sh                 Main utility to link the dotfiles on macOS.
└── ...                                 Dotfiles and config files and directories.
```


## Installation
Clone the git repository and then call the link script for your platform to link
the dotfiles into your system with `ln -s`:

```bash
git clone https://github.com/langenhagen/dotfiles.git
cd dotfiles
git pull origin master

./link-files-linux.sh
# or
./link-files-macos.sh
```

Running a link script will use `ln -sf` to create symlinks, overwriting any existing files or
symlinks at the target paths, or even call `rm` on files

There are other scripts in the root folder of the repository. Consider running them, too.

The two link scripts are deliberately standalone; neither sources the other, and shared links are
duplicated between them. Adding a file therefore means editing both scripts when the file applies to
both platforms.

### macOS Notes

- Install `vim` via Homebrew. The `vim` that ships with macOS is built without `+clipboard`, which
  silently breaks yanking to the system clipboard.
- macOS ships bash 3.2. The scripts here stay within that dialect, so no newer bash is required;
  keep it that way when editing them (no `mapfile`, no associative arrays).
- iTerm2 is configured separately; see `iterm2-config/README.md`.


## Making changes
You can configure the dotfiles simply via the paths symlinked into your home directory.  
When you add new files or want to remove dotfiles, please don't add them directly into your system,
but into the `dotfiles` folder, change the link scripts accordingly and then run the link script for
your platform. Restart the concerning programs to see the changes take effect.

### Opt-In Philosophy
The dotfiles generally link files rather than folders into the system. This happens in order to
allow for custom machine-specific configurations that may not land in the dotfiles.  
Exceptions may exist.


## Checking out other versions
When you do something like `git checkout mybranch`, links to the dotfiles created with `ln -s`,
especially links created by calling a link script will follow the old file versions that were in
place before the checkout. Call the link script again to make changes due to git checkouts take
effect.


## Contributing
Work on your stuff locally, branch, commit and modify to your heart's content.
As soon as you are ready, do:

```bash
git push origin HEAD:master
```

Happy coding!
