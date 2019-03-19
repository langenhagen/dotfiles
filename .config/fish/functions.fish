# My personal fish functions file
#
# Source this file into the config.fish.
#
# author: andreasl

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
        vim -R "+call feedkeys('/')" "$TRICKS_FILE_PATH"
    else if test (count $argv) -gt 0
        grep -in --color "$argv" $TRICKS_FILE_PATH
    end
end

function journal
    # shows the journal file or appends given input to it
    # there must be a trailing newline at the end of the file

    if test (count $argv) -eq 0
        tail -n20 "$JOURNAL_FILE_PATH"
    else if test (count $argv) -gt 0
        echo (date +%a' '%Y'-'%m'-'%d' '%H:%M) $argv >> "$JOURNAL_FILE_PATH"
    end
end

function minimerk
    # stores a simple text string into the minimerk.txt file with a timestamp
    # can be used for minimal reminders that are stored into persistent memory

    if test (count $argv) -eq 0
        tail -n20 "$HOME/.minimerk.txt"
    else if test (count $argv) -gt 0
        echo (date +%a' '%Y'-'%m'-'%d' '%H:%M) $argv >> "$HOME/.minimerk.txt"
    end
end

function bucket
    # shows the bucket list file or appends given lines to it
    # there must be a trailing newline at the end of the file

    if test (count $argv) -eq 0
        # -R readonly
        vim -R '+normal G\$' "$BUCKET_LIST_FILE_PATH"
    else if test (count $argv) -gt 0
        echo (date +%a' '%Y'-'%m'-'%d' '%H:%M) $argv >> "$BUCKET_LIST_FILE_PATH"
    end
end

function one-line-help
    if test (count $argv) -eq 0
        vim -R "$ONE_LINE_HELP_FILE_PATH"  # -R readonly
    else if test (count $argv) -gt 0
        # greps for the given arguments on the one-line-help.txt file
        grep -i --color=never "$argv" "$ONE_LINE_HELP_FILE_PATH"
    end
end

function add-to-one-line-help
    # adds a line to the one-line-help.txt file
    echo $argv >> "$ONE_LINE_HELP_FILE_PATH"

    set tmp_olh_bak_path (mktemp /tmp/one-line-help-backup.XXXXXXXX)
    cat $ONE_LINE_HELP_FILE_PATH >> $tmp_olh_bak_path
    sort -u -o $ONE_LINE_HELP_FILE_PATH $tmp_olh_bak_path
    rm $tmp_olh_bak_path
end

function addabr
    # adds a line to the abbreviations file and activates the abbreviation
    echo "abbr -a $argv" >> ~/.config/fish/abbreviations.fish
    abbr -a $argv
end

function replace
    if test (count $argv) -lt 3
        echo "Usage:  replace '*.cpp' [...] '<lookforthis>' '<replacewiththis>' "
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
        #find . -name "$file" -exec sed -i '' "s@$to_look_for@$to_replace_with@g" '{}' \;  # Mac sed version
        # It cannot be on *.* bc then it gives me an error like 'sed cannot be applied on . '
        find . -name "$file" -exec sed -i "s@$to_look_for@$to_replace_with@g" '{}' \;  # Gnu sed version
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

function cd-into-c1-project
    # Given a c1 repository name (without leading 'c1-',
    # changes the directory to the repository,
    cd "$HOME/c1/c1-$argv[1]"
end

function workon
    # Given a c1 repository name (without leading 'c1-',
    # changes the directory to the repository,
    # deactivates all conda environments and
    # activates the according conda environment.
    cd "$HOME/c1/c1-$argv[1]"
    if test $status != 0
        return
    end

    if test (conda info --envs | grep '*' | awk '{print $1}') = "$argv[1]"
        return
    end

    while test (conda info --envs | grep '*' | awk '{print $1}') != 'base'
        conda deactivate
    end
    conda activate $argv[1]
end

function rem
    # print a string in bold on the console in order to remember things.
    printf "\n\e[1m$argv\e[0m\n"\n
end

function printn
    # Prints a given string a given number of times.
    for i in (seq $argv[2])
        printf $argv[1]
    end
    printf $argv[3]
end

function fd
    find -L . -iname "*$argv*"
end

if [ (uname) = 'Darwin' ]

    function pbc
        # Copy a given argument to system clipboard.
        echo $argv | pbcopy
    end

    function pbce
        # copies the output of the given statement into the clipboard.
        # Better stick to the common way.
        eval $argv | pbcopy
    end

else

    function pbc
        # Copy a given argument to system clipboard.
        echo $argv | xclip -selection clipboard
    end

    function pbce
        # copies the output of the given statement into the clipboard.
        # Better stick to the common way.
        eval $argv | xclip -selection clipboard
    end

end
