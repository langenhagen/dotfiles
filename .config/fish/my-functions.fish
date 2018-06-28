# My personal fish functions file
# author: langenhagen
# version: 18-02-17

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
        vim -R ~/personal/Dev/Zeugs/tricks.md
    else if test (count $argv) -gt 0
        grep -in --color=never "$argv" ~/personal/Dev/Zeugs/tricks.md
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

function minimerk
    # stores a simple text string into the minimerk.txt file with a timestamp
    # can be used for minimal reminders that are stored into long term memory

    if test (count $argv) -eq 0
        tail -n20 ~/stuff/minimerk.txt
    else if test (count $argv) -gt 0
        echo (date +%a' '%Y'-'%m'-'%d' '%H:%M) $argv >> ~/stuff/minimerk.txt
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
        vim -R ~/stuff/one-line-helps/one-line-help-(whoami)-(hostname -s).txt  # -R readonly
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

function pbce
    # copies the output of the given statement into the clipboard.
    # Better stick to the common way.
    eval $argv | pbcopy
end

function vimh
    # opens a vim tab for each line of output with all the outputs of the last statement.
    # e.g. use in conjunction with `ls -1` or `find` or `grep -lr`
    # note: I tried to make it an alias, but $history[1] will, once evaluated in the abbreviation,
    #       expandend and thus stay immutable within this abbreviation.
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

function hrn
    # grep -H: print filename headers,  -n: prinft line numbers,  -r: recursive,  -s: suppress error messages
    grep -Hirns --exclude-dir=".git" --color $argv[1] .
end

function hrni
    # grep -H: print filename headers, -n: print line numbers,   -r: recursive
    #      -I: ignore binary files
    grep -HirnsI --exclude-dir=".git" --color $argv[1] .
end

function chrn
    grep -Hirns --exclude-dir=".git" \
                --include \*.h --include \*.hpp --include \*.cpp --include \*.m --include \*.mm \
                --include \*.pch --include \*.java --include \*.swift --include \*.cc \
                --include \*.kt \
                --color $argv[1] .
end

function cmhrn
    grep -Hirns --exclude-dir=".git" --include CMakeCache.txt --include CmakeLists.txt --include \*.cmake --color $argv[1] .
end

function jhrn
    grep -Hirns --exclude-dir=".git" --include \*.java --color $argv[1] .
end

function clrn
    # -l, --files-with-matches: Only the names of files containing selected lines are written to standard output.
    #  grep will only search a file until a match has been found, making searches potentially less expensive. [...]
    grep -lirns --exclude-dir=".git" --include \*.h --include \*.cpp --include \*.m \
                --include \*.mm --include \*.pch --color $argv[1] .
end

function sclrn
    # open the files found with clirn in sublime text.
    sb ( clirn $argv[1] .)
end

function pyhrn
    grep -Hirns --exclude-dir=".git" --include \*.py --color $argv[1] .
end

function pylrn
    grep -lirns --exclude-dir=".git" --include \*.py --color $argv[1] .
end

function lrn
    # -l, --files-with-matches: Only the names of files containing selected lines are written to standard output.
    grep -lirns --exclude-dir=".git" $argv[1] .
end

function slrn
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

function pushover
    # echoes the given input and
    # sends the input as a string as push notification via pushover.
    set pushover_app_token agna4fob6wu7e7t2ofhz1drt7ptngq       # change according to app/platform
    set pushover_user_token ucw67xi5r5mqgqo8arh3p64xkj39wu

    echo "pushover: $argv"
    curl --silent \
         --form-string "token=$pushover_app_token" \
         --form-string "user=$pushover_user_token" \
         --form-string "message=$argv" \
         https://api.pushover.net/1/messages.json
end
