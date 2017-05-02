# Dotfiles

author: langenhagen
version: 170502

This folder cointains a bunch of .dotfiles and /.dotfolders to configure
Your UNIX environment and applications.


The dotfiles can be linked into Your system with ln, effectively keeping them up-to-date
in this folder and thus enabling to keep them up-to date on each machine.
Create a branch for each machine.

Caution: links created with ln will follow the old files when You do something like

```
git checkout HEAD
```

on a file. Thus, this won't undo changes to the linked files. You need to re-link them again.
Linking can be done like in the following. Maybe it can be actually easier.

```
rm ~/.vimrc;                    and ln ~/personal/Dev/Zeugs/dotfiles/.vimrc                     ~/.vimrc
rm ~/.tigrc;                    and ln ~/personal/Dev/Zeugs/dotfiles/.tigrc                     ~/.tigrc
rm ~/.tigr;                     and ln ~/personal/Dev/Zeugs/dotfiles/.tigrc                     ~/.tigrc
rm ~/.gitignore_global;         and ln ~/personal/Dev/Zeugs/dotfiles/.gitignore_global          ~/.gitignore_global
rm ~/.gitignore_global;         and ln ~/personal/Dev/Zeugs/dotfiles/.gitignore_global          ~/.gitconfig
rm ~/.gitconfig;                and ln ~/personal/Dev/Zeugs/dotfiles/.gitconfig                 ~/.gitconfig
rm ~/.config/fish/config.fish;  and ln ~/personal/Dev/Zeugs/dotfiles/.config/fish/config.fish   ~/.config/fish/config.fish
rm ~/.config/bpython/config;    and ln ~/personal/Dev/Zeugs/dotfiles/.config/bpython/config     ~/.config/bpython/config
rm ~/.ccache/ccache.conf;       and ln ~/personal/Dev/Zeugs/dotfiles/.ccache/ccache.conf        ~/.ccache/ccache.conf
```
