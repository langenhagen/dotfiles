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

function tricks
    # Show the tricks file and enable grepping on it.

    if test (count $argv) -eq 0
        # -R readonly
        vim -R "+call feedkeys('/')" "$TRICKS_FILE_PATH"
    else if test (count $argv) -gt 0
        grep -in --color "$argv" $TRICKS_FILE_PATH
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

function one-line-help
    # Grep for the given arguments on the one-line-help.txt file.
    if test (count $argv) -eq 0
        vim -R "$ONE_LINE_HELP_FILE_PATH"  # -R readonly
    else
        set results (grep -i --color=never "$argv[1]" "$ONE_LINE_HELP_FILE_PATH")
        for arg in $argv
            set results (printf -- '%s\n' $results | grep -i --color=never "$arg")
        end
        printf -- '%s\n' $results
    end
end

function add-to-one-line-help
    # Add a line to the one-line-help.txt file.
    echo $argv >> "$ONE_LINE_HELP_FILE_PATH"

    set tmp_olh_bak_path (mktemp /tmp/one-line-help-backup.XXXXXXXX)
    cat $ONE_LINE_HELP_FILE_PATH >> $tmp_olh_bak_path
    sort -u -o $ONE_LINE_HELP_FILE_PATH $tmp_olh_bak_path
    rm $tmp_olh_bak_path
end

function addabr
    # Add a line to the abbreviations file and activate the abbreviation.
    echo "abbr -a $argv" >> ~/.config/fish/abbreviations.fish
    abbr -a $argv
end

function pushover
    # Echoes the given input and
    # send the input as a string as push notification via pushover.
    set pushover_app_token agna4fob6wu7e7t2ofhz1drt7ptngq  # change according to app/platform
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
    # change the directory to the repository,
    cd "$HOME/c1/gerrit/c1-$argv[1]"
end

function workon
    # Given a c1 repository name (without leading 'c1-',
    # change the directory to the repository,
    # deactivate all conda environments and
    # activate the according conda environment.
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
    # Print a given string a given number of times.
    for i in (seq $argv[2])
        printf $argv[1]
    end
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
