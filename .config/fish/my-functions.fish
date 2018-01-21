# My personal fish functions file
# author: langenhagen
# version: 18-01-21

# source this file into the config.fish


function read_confirm_prompt
    echo 'Do you want to continue? [yY/nN] '
end

function read_confirm
  # performs a Yes/No confirmation check by the user via the keyboard.

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

function tricks
    # shows the tricks file and enables grepping on it

    if test (count $argv) -eq 0
        # -R readonly
        vim -R ~/stuff/tricks.md
    else if test (count $argv) -gt 0
        grep -in --color=never "$argv" ~/stuff/tricks.md
    end
end

function journal
    # shows the journal file or appends given input to it
    # there must be a trailing newline at the end of the file

    if test (count $argv) -eq 0
        tail -n20 ~/stuff/Journal.txt
    else if test (count $argv) -gt 0
        echo (date +%a' '%Y'-'%m'-'%d' '%H:%M) $argv >> ~/stuff/Journal.txt
    end
end

function bucket
    # shows the bucket list file or appends given lines to it
    # there must be a trailing newline at the end of the file

    if test (count $argv) -eq 0
        # -R readonly
        vim -R "+normal G\$" ~/stuff/BucketList.txt      # \$ instead of $ is necessary bc of fish
    else if test (count $argv) -gt 0
        echo (date +%a' '%Y'-'%m'-'%d' '%H:%M) $argv >> ~/stuff/BucketList.txt
    end
end

function olh
   if test (count $argv) -eq 0
        # -R readonly
        vim -R ~/stuff/one-line-helps/one-line-help-(whoami)-(hostname -s).txt
    else if test (count $argv) -gt 0
        # greps for the given arguments on the one-line-help.txt file
        grep -i --color=never "$argv" ~/stuff/one-line-helps/one-line-help-(whoami)-(hostname -s).txt
    end
end

function alh
    # adds a line to the one-line-help.txt file
    echo $argv >> ~/stuff/one-line-helps/one-line-help-(whoami)-(hostname -s).txt
end

function addabr
    # adds a line to the abbreviations file and activates the abbreviation
    echo "abbr -a $argv" >> ~/.config/fish/my-abbreviations.fish
    abbr -a $argv
end

function mkfav
    ln -s (pwd) /Users/langenha/stuff/shortcuts/$argv[1]
end

function pbc
    # copy given argument to system clipboard
   echo $argv | pbcopy
end

function gitup
    echo (pwd)
    cd (git rev-parse --show-toplevel)
end

function pbce
    # copies the output of the given statement into the clipboard.
    # Better stick to the common way.
    eval $argv | pbcopy
end

function vimh
    # opens a vim tab for each line of output with all the outputs of the last statement.
    # e.g. use in conjunction with `ls -1` or `find` or `grep -lr`
    vim -p (eval $history[1])
end

function oh
    # interprets the most recent line of output as a path and attempts to open it
    # with the standard application.
    # note: I tried to make it an alias, but $history[1] will, once evaluated in the abbreviation,
    #       expandend and thus stay immutable within this abbreviation.
    open (eval $history[1])
end

function ohf
    # interprets the most recent line of output as a path and attempts to open it
    # with the standard application.
    # note: I tried to make it an alias, but $history[1] will, once evaluated in the abbreviation,
    #       expandend and thus stay immutable within this abbreviation.
    open -R (eval $history[1])
end

function fn2
    find . -iname "*$argv*"
end

function hirni
    # grep -H: print filename headers, -n: print line numbers,   -r: recursive
    #      -I: ignore binary files
    grep -HirnI --color $argv[1] .
end

function hirn
    # grep -H: print filename headers,   -n: prinft line numbers,   -r: recursive
    grep -Hirn --color $argv[1] .
end

function chirn
    grep -Hirn --include \*.h --include \*.cpp --include \*.m --include \*.mm --include \*.pch --include \*.java --include \*.swift --color $argv[1] .
end

function jhirn
    grep -Hirn --include \*.java --color $argv[1] .
end

function clirn
    # -l, --files-with-matches: Only the names of files containing selected lines are written to standard output.
    #  grep will only search a file until a match has been found, making searches potentially less expensive. [...]
    grep -lirn --include \*.h --include \*.cpp --include \*.m --include \*.mm --include \*.pch --color $argv[1] .
end

function sclirn
    sb ( clirn $argv[1] .)
end

function pyhirn
    grep -Hirn --include \*.py --color $argv[1] .
end

function pylirn
    grep -lirn --include \*.py --color $argv[1] .
end

function lirn
    grep -lirn $argv[1] .
end

function slirn
    sb ( lirn $argv[1] .)
end

function replace
    if test (count $argv) -lt 3
        echo "Usage:  replace '*.h' '.cpp' [...] '<lookforthis>' '<replacewiththis>' "
        return
    end

    set n_files (math (count $argv) - 2)
    set to_look_for $argv[(math (count $argv) - 1)]
    set to_replace_with $argv[(count $argv)]

    for file in $argv[1..$n_files]
        # show potential changes before actual replacement
        grep -Hrn --color --include $file $to_look_for .
    end

    if not read_confirm
        return
    end

    for file in $argv[1..$n_files]
        # find will execute -exec and substitute {} with what it found
        # whereas with + as many files as possible are given as parameters to sed at once.
        #find . -name "$file" -exec sed -i '' "s@$to_look_for@$to_replace_with@g" '{}' +  # Mac sed version
        # It cannot be on *.* bc then it gives me an error like 'sed cannot be applied on . '
        find . -name "$file" -exec sed -i "s@$to_look_for@$to_replace_with@g" '{}' +  # Gnu sed version
    end
end

function gitfileschanged
    # given two commit numbers lists all the files that have been changed in the given commits
    # in the manner from HEAD~n to HEAD~m

    if test (count $argv) -lt 2
        echo "Usage: gitfileschanged <firstcommitnumber> <secondcommitnumber>"
        return
    end

    for n in (seq $argv[1] $argv[2])
        set get_files_from_commit_n "git diff-tree --no-commit-id --name-only -r HEAD~$n"
        set get_files_from_all_commits "$get_files_from_all_commits ; $get_files_from_commit_n"
    end
    eval "$get_files_from_all_commits" | sort -u

end