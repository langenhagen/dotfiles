# My personal fish functions file
#
# Source this file into the config.fish.
#
# author: andreasl

function read_confirm_prompt
    echo 'Do you want to continue? [yY/nN] '
end

function read_confirm
  # Perform a Yes/No confirmation check by the user via the keyboard.
  while true
    read -l -p read_confirm_prompt confirm

    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end

function journal
    # Show the journal file or append given input to it.
    # There must be a trailing newline at the end of the file or else output might be fucked up.

    if test (count $argv) -eq 0
        tail -n20 "$JOURNAL_FILE_PATH"
    else if test (count $argv) -gt 0
        echo (date +%a' '%Y'-'%m'-'%d' '%H:%M) $argv >> "$JOURNAL_FILE_PATH"
    end
end

function minimerk
    # Store a simple text string into the minimerk.txt file with a timestamp.
    # Can be used for minimal reminders that are stored into persistent memory.

    if test (count $argv) -eq 0
        tail -n20 "$HOME/.minimerk.txt"
    else if test (count $argv) -gt 0
        echo (date +%a' '%Y'-'%m'-'%d' '%H:%M) $argv >> "$HOME/.minimerk.txt"
    end
end

function bucket
    # Show the bucket list file or append given lines to it.
    # There must be a trailing newline at the end of the file.

    if test (count $argv) -eq 0
        # -R readonly
        vim -R '+normal G\$' "$BUCKET_LIST_FILE_PATH"
    else if test (count $argv) -gt 0
        echo (date +%a' '%Y'-'%m'-'%d' '%H:%M) $argv >> "$BUCKET_LIST_FILE_PATH"
    end
end

function addabr
    # Add a line to the abbreviations file and activate the abbreviation.
    echo "abbr -a $argv" >> ~/.config/fish/abbreviations.fish
    abbr -a $argv
end

function cd-into-c1-project
    # Given a c1 repository name (without leading 'c1-',
    # change the directory to the repository,
    cd "$HOME/c1/gerrit/c1-$argv[1]"
end

function rem
    # print a string in bold on the console in order to remember things.
    printf "\n\e[1m$argv\e[0m\n"\n
end

if [ (uname) = 'Darwin' ]
    function pbc
        # Copy a given argument to system clipboard.
        echo $argv | pbcopy
    end

    function pbce
        # Copy the output of the given statement into the clipboard.
        # Better stick to the common way.
        eval $argv | pbcopy
    end
else
    function pbc
        # Copy a given argument to system clipboard.
        echo $argv | xclip -selection clipboard
    end

    function pbce
        # Copy the output of the given statement into the clipboard.
        # Better stick to the common way.
        eval $argv | xclip -selection clipboard
    end
end

function pip
    # Allow using pip if a conda environment is active, even if PIP_REQUIRE_VIRTUALENV is set.
    [ -n "$CONDA_PREFIX" ]; and set -lx PIP_REQUIRE_VIRTUALENV false;
    eval (which pip) "$argv";
end

switch (uname -n)
case "*celeraone*"
    # C1 related functions

    function rt
        # Conveniently run robot tests.
        printf "bin/pybot -L TRACE --test \"*$argv*\" test/\n\n"
        command -v bin/pybot; and bin/pybot -L TRACE --test "*$argv*" test/
    end
end
