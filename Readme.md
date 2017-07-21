# Dotfiles

author: langenhagen
version: 1700721

This folder cointains a bunch of .dotfiles and /.dotfolders to configure
Your UNIX environment and applications. It may also contain exportable settings from other programs.


## Linking the dotfiles into your machine

The dotfiles can be linked into Your system with `ln`, effectively keeping them up-to-date
in this folder and thus enabling to keep them up-to date on each machine.

Check out the script `link-files.sh` which links the dotfiles and also sets application
settings, when applicable.


Caution: When you do something like `git checkout HEAD` , links to the dotfiles created with `ln`
will follow the old file versions. Thus, this won't undo changes to the linked files.
You need to re-link them again.


## Submitting changes

### Submit to existing branch

Create a branch for each machine you want to maintain. Submit to an existing branch by doing
`git add .` and then `git commit`. Then do `git push origin <HEAD>:<branchname>`.


### Submit to new branch.

First, checkout on a new branch on your own machine by doing `git checkout -b <branchname>`.
Then do `git push origin <HEAD>:<branchname>`.