# Dotfiles
author: andreasl

A bunch of .dotfiles and /.dotfolders to configure your UNIX environment.
It may also contain exported settings from other programs.

The project is structured as follows:
```
.
├── README.md               You are here now.
├── link-files.sh           Utility to link the dotfiles.
└── ...                     Dotfiles...
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

Beware that executing `link-files.sh` eventually deletes existing files before it symlinks the
dotfiles. Also, you might see some error messages like `rm: $HOME/ranger/rc.conf: No such file or
directory` at first installation because the script will attempt to delete files may not exist.
This is fine however.


## Making changes
You can configure the dotfiles simply via the paths symlinked into your home directory.
When you add new files or want to remove dotfiles, please don't add them directly into
your system, but into the `dotfiles` folder, change the `link-files.sh` accordingly and
then run `link-files.sh`. Start a terminal session to see the changes taking effect.

### Opt-In Philosophy
The dotfiles generally link files rather than folders into the system. This happens in order to
allow for custom machine-specific configurations that may not land in the dotfiles.
One notable exception is the folder `sublime-text-3/Packages`.


## Checking out other versions
When you do something like `git checkout HEAD`, links to the dotfiles created with `ln -s`,
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
