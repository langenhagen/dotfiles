# vimlike-bookmarks.fish
#
# Provides functions for managing bookmarks similar to bookmrks in vim
# and creates abbreviations for changing directories to these bookmarks similar to the commands that
# exist in vim, but for fish, the friendly interactive shell.
#
# author: andreasl
# version: 18-08-29

function m
    # Sets abbreviations for `<char> and '<char> for cd-ing into the current directory.

    if [ (count $argv) -ne 1 ]; or [ "$argv[1]" = '-h' ]; or [ "$argv[1]" = '--help' ];
        printf 'Usage: Provide one argument that shall be part of the bookmark:\n'
        printf "    $_ <char>\n"
        printf '\n'
        printf 'Example:\n'
        printf "    $_ a            will resolve in bookmark abbreviations 'a and `a\n"
        return 1
    end

    abbr -a "'$argv[1]" "cd $PWD"
    abbr -a "`$argv[1]" "cd $PWD"
end

function marks
     # Prints either all abbreviations or a subset
     # or the ones that belong to the given characters.

    set awkcommand '{
        printf substr($2,3) "    ";
        for(i=4 ; i<NF ; ++i) {
            printf "%s"
        };
        printf substr($NF, 1, length($NF)-1) "\n"; }
    '
    if test (count $argv) -eq 0
        abbr --show | grep "\'.*'cd " | awk "$awkcommand"
    else
        abbr --show | grep "\'[$argv].*'cd " | awk "$awkcommand"
    end
end

function delmarks
    # Erases the abbreviations that belong to the given characters
    # or, if no character is given, prints a message with the usage.

    if [ (count $argv) -lt 1 ];
        printf 'Usage: Provide one or more arguments that specify vimlike bookmarks:\n'
        printf "    $_ <char> [<char>]*\n"
        printf '\n'
        printf 'Example:\n'
        printf "    $_ a            will erase the bookmars `a and 'a\n"
        return 1
    end

    for bookmark in $argv
        abbr --erase "'$bookmark"
        abbr --erase "`$bookmark"
    end
end