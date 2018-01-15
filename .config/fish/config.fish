# My personal fish config file for a mac machine
# author: langenhagen
# version: 17-11-27

### more sourcing ##################################################################################

# iterm2 shell integration
source ~/.iterm2_shell_integration.fish

######### IMMUTABLE SYSTEM EXPORTS  ...somehow relevant ;) #########################################

set fish_greeting "" # deactivates the fish welcome message

setenv CODE_DIR "/Users/langenha/code"
setenv SCRIPTS_DIR "$CODE_DIR/scripts"
setenv JAVA_HOME "/Library/Java/JavaVirtualMachines/jdk1.8.0_141.jdk/Contents/Home"
 setenv Z_SCRIPT_PATH /usr/local/etc/profile.d/z.sh
setenv ANDROID_HOME /Users/langenha/Library/Android/sdk
setenv ANDROID_NDK_HOME /Users/langenha/Library/Android/sdk/ndk-bundle
setenv SDK_ROOT $ANDROID_HOME
setenv NDK_ROOT $ANDROID_NDK_HOME
setenv OPENSSL_ROOT_DIR "/usr/local/Cellar/openssl/1.0.2h_1/"
setenv CCACHE_PREFIX icecc
setenv WORKSPACE "/Users/langenha/code/sparta" # used for sparta CMake scripts to identify workspace

set -gx PATH $PATH $SCRIPTS_DIR
set -gx PATH $PATH /usr/local/sbin
set -gx PATH $PATH /usr/local/opt/icecream/libexec/icecc/bin
set -gx PATH $PATH $ANDROID_HOME/tools
set -gx PATH $PATH $ANDROID_HOME/platform-tools


setenv ANDROID_SERIAL CB5A286QVE            # that's my SONY XPeria Z5 Compact
#setenv ANDROID_SERIAL 024475e094d2743e      # that's the LG Nexus with PTM #245


setenv  AndisVariable "jojojo"


######### MUTABLE SYSTEM EXPORTS ###################################################################


######### ABBREVIATIONS ############################################################################

abbr -a fishconfig vim ~/.config/fish/config.fish
abbr -a fconf vim ~/.config/fish/config.fish
abbr -a fic vim ~/.config/fish/config.fish
abbr -a sourcefish . ~/.config/fish/config.fish
abbr -a srcf . ~/.config/fish/config.fish
abbr -a editabbr vim -p ~/.config/fish/my-abbreviations.fish

abbr -a jrn journal
abbr -a bkt bucket
abbr -a tks tricks
abbr -a editjrn 'vim -R "+normal G\$" -p ~/stuff/Journal.txt'
abbr -a ej 'vim -R "+normal G\$" -p ~/stuff/Journal.txt'
abbr -a gitp gitup


######### SOURCE MORE ABBREVIATIONS ################################################################

source ~/.config/fish/my-abbreviations.fish


######### EDUCATIONAL AND ERRATIC ##################################################################

function testfishfunction
    # a simple educational function in order not to repeat some errors all too often :)
    # info about fish functions:
    # fish arrays start at 1
    #   $argv: arguments of the function (and only the arguments!)
    #   (count $argv) can be 1 .. n
    #    $argv[0] : error index out of bounds

    echo '--- testfishfunction START'



    echo '--- testfishfunction END'
end


######### HELPER FUNCTIONS #########################################################################

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


######### NICE FUNCTIONS ###########################################################################

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


######### IMMUTATBLE SCRIPT INVOKING ALIASES #######################################################

alias spo="bash $SCRIPTS_DIR/send_pushover.sh"


######### PRIVATE HELPER FUNCTIONS #################################################################


######### FUNCTIONS ################################################################################


######### THE INITIAL COMMANDS #####################################################################

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

cd ~/code/sparta
