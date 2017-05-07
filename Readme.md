# Dotfiles

author: langenhagen
version: 18-01-21

This folder cointains a bunch of .dotfiles and /.dotfolders to configure
Your UNIX environment and applications. It may also contain exportable settings from other programs.


## Getting and Linking the Dotfiles into Your Machine

```bash
cd ~
git clone https://github.com/langenhagen/dotfiles.git
cd dotfiles
git pull origin Mac-Workmachine
git checkout -b Mac-Workmachine
bash link-files.sh
```


The script `link-files.sh` links the dotfiles into Your system with `ln`,
effectively keeping them up-to-date in this folder and thus enabling to keep them up-to date
on each machine.


**Caution**: When you do something like `git checkout HEAD`, links to the dotfiles created with `ln`
will follow the old file versions. Thus, this won't undo changes to the linked files.
You need to re-link them again.


## Submitting changes

### Submit to existing branch

Create a branch for each machine you want to maintain. Submit to an existing branch by doing
`git add .` and then `git commit`. Then do `git push origin <HEAD>:<branchname>`.


### Submit to new branch.

First, checkout on a new branch on your own machine by doing `git checkout -b <branchname>`.
Then do `git push origin <HEAD>:<branchname>`.

