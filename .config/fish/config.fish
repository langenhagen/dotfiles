### more sourcing ##################################################################################

# iterm2 shell integration
source ~/.iterm2_shell_integration.fish

######### IMMUTABLE SYSTEM EXPORTS  ...somehow relevant ;) #########################################

set fish_greeting "" # deactivates the fish welcome message

setenv CODE_DIR "/Users/langenha/code"
setenv SCRIPTS_DIR "$CODE_DIR/scripts"


setenv Z_SCRIPT_PATH /usr/local/etc/profile.d/z.sh
setenv PATH $PATH $SCRIPTS_DIR /usr/local/sbin
setenv PATH $PATH /Users/$USER/Library/Android/sdk/platform-tools/

setenv ANDROID_SERIAL CB5A286QVE            # that's my SONY XPeria Z5 Compact
#setenv ANDROID_SERIAL 024475e094d2743e      # that's the LG Nexus with PTM #245


export OPENSSL_ROOT_DIR="/usr/local/Cellar/openssl/1.0.2h_1/"
export MIGRANT_DIR="/Users/langenha/code/olympia-prime/auto-core-sdk/migrant/"
export HCVD_MIGRATIONS_DIR="/Users/langenha/code/olympia-prime/auto-core-sdk/sdk_extensions/migrations"

export AndisVariable="jojojo"


######### MUTABLE SYSTEM EXPORTS ###################################################################

setenv ACS_ENVIRONMENT "<will_be_set_by_function>"

setenv ACS_MAIN_DIR "<will_be_set_by_function>"
setenv ACS_BUILD_DIR "<will_be_set_by_function>"

setenv PYTHONPATH "<will_be_set_by_function>"
setenv CMAKE_BUILD_ROOT "<will_be_set_by_function>"        # for apache ant for the jni tests or so

######### ABBREVIATIONS ############################################################################

abbr -a gco git checkout
abbr -a gbd git branch -D
abbr -a gb  git branch
abbr -a gs git status
abbr -a gca git commit --amend
abbr -a gcs git checkout staging
abbr -a gcb git checkout -b
abbr -a gbn git checkout -b
abbr -a gnb git checkout -b
abbr -a gp git push origin HEAD:refs/for/staging
abbr -a gpl git pull origin staging
abbr -a gpos git pull origin staging
abbr -a gri git rebase --interactive HEAD~
abbr -a gpr git pull --rebase origin staging
abbr -a grhh git reset --hard HEAD
abbr -a grsh git reset --soft HEAD~1
abbr -a cdd cd ~/Desktop
abbr -a tks tricks
abbr -a jrn journal
abbr -a bkt bucket
abbr -a favs cdfavs
abbr -a opn open
abbr -a fnd find . -iname
abbr -a fnd1 find . -maxdepth 1 -iname
abbr -a t3 tree -L 3
abbr -a t3d tree -L 3 -d
abbr -a cddotfiles cd /Users/langenha/personal/Dev/Zeugs/dotfiles
abbr -a gitp gitup
abbr -a vim vim -p

######### EDUCATIONAL AND ERRATIC ##################################################################

function testfishfunction
    # a simple educational function in order not to repeat some errors all too often :)
    # info about fish functions:
    # fish arrays start at 1
    #   $argv: arguments of the function (and only the arguments!)
    #   (count $argv) can be 1 .. n
    #    $argv[0] : error index out of bounds

    echo '--- testfishfunction START'
    echo argv-count: (count $argv)
    echo 'All of the the argv: ' $argv
    echo $argv[1]  # no error - never (weird)
    echo '--- testfishfunction END'
end

function fff

    # test fish function for experimental purposes
    echo '--- fff START'

    echo '--- fff END'
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

function mkfav
    ln -s (pwd) /Users/langenha/stuff/shortcuts/$argv[1]
end

function pbc
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
    grep -Hirn --include \*.h --include \*.cpp --include \*.m --include \*.mm --include \*.pch --color $argv[1] .
end

function jhirn
    grep -Hirn --include \*.java --color $argv[1] .
end

function clirn
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
        grep -Hrn --color --include $file $to_look_for .
        # find will execute -exec and substitute {} with what it found
        # whereas with + as many files as possible are given as parameters to sed at once
        find . -name "$file" -exec sed -i '' "s@$to_look_for@$to_replace_with@g" '{}' +
    end
end

######### IMMUTABLE GNERIC ALIASES #################################################################

alias fishconfig="vim ~/.config/fish/config.fish"
alias sourcefish=". ~/.config/fish/config.fish"

alias cd..="cd .."

alias sb="sublime"

alias textmate="open -a TextMate"
alias tm="open -a TextMate"

alias t="tig"
alias tg="tig"

alias xcode="open -a Xcode"
alias xc="open -a Xcode"

alias bpython='/usr/local/bin/python -m bpython' # makes my bpython point to my own python version      (160817: 2.7.11)
alias bp='/usr/local/bin/python -m bpython'      # makes my bpython point to my own python version      (160817: 2.7.11)

alias sp='sb /Users/langenha/personal/Barn/Text/Spanish.txt'

alias sbscbeterm='sb /Users/langenha/code/ScbeTerminal/ScbeTerminal.py'
alias scbeterm='python /Users/langenha/code/ScbeTerminal/ScbeTerminal.py'


######### IMMUTATBLE SCRIPT INVOKING ALIASES #######################################################

alias rmake="bash $SCRIPTS_DIR/the-cmake-script.sh"
alias rats="bash $SCRIPTS_DIR/rats.sh"
alias newtask="bash $SCRIPTS_DIR/new-task.sh"
alias spo="bash $SCRIPTS_DIR/send_pushover.sh"

######### IMMUTABLE CD ALIASES #####################################################################

alias cdcode="cd $CODE_DIR"
alias cdcde="cd $CODE_DIR"
alias cddocker="cd $CODE_DIR/docker"
alias cdscripts="cd $SCRIPTS_DIR"
alias cdstuff="cd $HOME/stuff"
alias cdfavs="cd $HOME/stuff/shortcuts; and ls -1"

alias cdand="cd $CODE_DIR/android"
alias cdios="cd $CODE_DIR/AMSDK-iOS"
alias cdiosp="cd $CODE_DIR/AmsDemo1"
alias cdiosr="cd $CODE_DIR/AmsDemo2"

######### IMMUTABLE GIT ALIASES ####################################################################

alias gnb="git checkout staging; and git pull origin staging; and git checkout -b"


######### OLYMPIA RELATED ALIASES ##################################################################

alias mockscbe=" \
                 cd $CODE_DIR/olympia-prime/mib2plus-integration/tests/mock_scbe; and \
                 python mock_scbe.py
               "

######### MUTABLE ALIASES ##########################################################################

function set_aliases
    #
    # aliases are evaluated on sourcing, therefore they have to be set again when variables change
    #

    alias cdacs=" \
                  clear; \
                  cd $ACS_MAIN_DIR; and \
                  echo '-----------------------------------------------'; \
                  git branch; \
                  echo '-----------------------------------------------' \
                "

    alias cdmib=" \
                  clear; \
                  cd $ACS_MAIN_DIR/../mib2plus-integration; and \
                  echo '-----------------------------------------------'; \
                  git branch; \
                  echo '-----------------------------------------------' \
                "

    alias cdab="cd $ACS_BUILD_DIR"

end

######### TESTING FUNCTIONS ########################################################################

function gt
    pushd .
    cd $ACS_BUILD_DIR ;
    cd auto-core-sdk/sdk_extensions/tests/unit/
    ./carlo_sdl_unit_tests -v $argv;
    popd
end

function gtf
    pushd .
    cd $ACS_BUILD_DIR ;
    cd auto-core-sdk/sdk_extensions/tests/unit/
    ./carlo_sdl_unit_tests -v $argv > $ACS_BUILD_DIR/unit_tests_out.txt 2>&1;
    popd
end

function bgt
    # build run google test
    pushd .
    cd $ACS_BUILD_DIR;

    ninja carlo_sdl_unit_tests ;
    if test $status != 0
        return
    end

    gt $argv;
    popd
end

function bgtf
    # build run google test, bail out on test fail
    pushd .
    cd $ACS_BUILD_DIR;

    ninja carlo_sdl_unit_tests ;
    if test $status != 0
        return
    end

    gtf $argv;
    popd
end

function uto
    sb $ACS_BUILD_DIR/unit_tests_out.txt
end

#
# for the smoke and integration tests, maybe a dylib must be linked into the cwd
#
# possible command line options for the integration/smoke tests (besides wildcards) are:
#       --log-to-stdout

function brit
    if test (count $argv) -eq 0
      set argv $argv "test*"
    end

    pushd .
    cd $ACS_BUILD_DIR;

    ninja carlo_sdl_integration_tests;

    if test $status != 0
      return
    end

    cd auto-core-sdk/sdk_extensions/tests/integration/runner
    ./carlo_sdl_integration_tests \
    $ACS_MAIN_DIR/sdk_extensions/tests/integration/test.py $argv ;
    popd
end

function rit
    if test (count $argv) -eq 0
        set argv $argv "test*"
    end

    pushd .
    cd $ACS_BUILD_DIR;
    cd auto-core-sdk/sdk_extensions/tests/integration/runner
    ./carlo_sdl_integration_tests \
    $ACS_MAIN_DIR/sdk_extensions/tests/integration/test.py $argv[1] ;
    popd
end

function brst
    if test (count $argv) -eq 0
        set argv $argv "test*"
    end

    pushd .
    cd $ACS_BUILD_DIR;
    ninja carlo_sdl_integration_tests;

    if test $status != 0
        return
    end

    auto-core-sdk/sdk_extensions/tests/integration/runner/carlo_sdl_integration_tests \
    $ACS_MAIN_DIR/sdk_extensions/tests/integration/smoke/test.py $argv[1] ;
    popd
end

function rst
    if test (count $argv) -eq 0
        set argv $argv "test*"
    end

    pushd .
    cd $ACS_BUILD_DIR ;
    auto-core-sdk/sdk_extensions/tests/integration/runner/carlo_sdl_integration_tests \
    $ACS_MAIN_DIR/sdk_extensions/tests/integration/smoke/test.py $argv[1] ;
    popd
end

function cmakeadds
    # this is a rare function to do additional tasks that cmake doesn't do by itself
    # cmake additionals
    mkdir $ACS_BUILD_DIR
    ln -sf $ACS_BUILD_DIR/auto-core-sdk/locationsdk/samples/positioning/glsempty/libgls.dylib $ACS_BUILD_DIR
end

######### PRIVATE HELPER FUNCTIONS #################################################################

function _setEnvironment_

    setenv ACS_ENVIRONMENT $argv[1]

    setenv ACS_MAIN_DIR $argv[2]
    setenv ACS_BUILD_DIR $argv[3]

    setenv PYTHONPATH "$ACS_BUILD_DIR/auto-core-sdk/sdk_extensions/build/sdl/python/"
    setenv CMAKE_BUILD_ROOT $ACS_BUILD_DIR                  # for apache ant for the jni tests

    set_aliases

    cd $ACS_MAIN_DIR

    clear
    echo '-----------------------------------------------'
    echo $ACS_ENVIRONMENT
    echo 'ACS_MAIN_DIR: '  $ACS_MAIN_DIR
    echo 'ACS_BUILD_DIR: ' $ACS_BUILD_DIR
    echo '-----------------------------------------------'
    git branch
    echo '-----------------------------------------------'


end

######### FUNCTIONS ################################################################################

function setAcsOlympia

    _setEnvironment_ "ACS Olympia Ninja" \
                     "$CODE_DIR/olympia-prime/auto-core-sdk" \
                     "$CODE_DIR/olympia-prime/build"
end

function setACSXCodeXCode

    _setEnvironment_ "ACS Xcode Xcode" \
                     "$CODE_DIR/AMSDK-iOS/External/hcvd/prime/auto-core-sdk" \
                     "$CODE_DIR/AMSDK-iOS/External/hcvd/prime/build-xcode"
end


function setACSXCodeNinja

    _setEnvironment_ "ACS Xcode Ninja" \
                     "$CODE_DIR/AMSDK-iOS/External/hcvd/prime/auto-core-sdk" \
                     "$CODE_DIR/AMSDK-iOS/External/hcvd/prime/build-ninja"
end

######### THE INITIAL COMMANDS #####################################################################

setAcsOlympia
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
