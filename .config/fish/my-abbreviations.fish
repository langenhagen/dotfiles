# this file contains custom fish abbreviations
#
# author: andreasl
# version: 2018-08-29

abbr -a xo 'xargs open'
abbr -a xv 'xargs -o vim -p'  # xargs -o: Reopen stdin as /dev/tty in the child process before executing the command
abbr -a xx 'xargs -o vim -p'  # xargs -o: Reopen stdin as /dev/tty in the child process before executing the command
abbr -a xs 'xargs sublime'
abbr -a !! 'eval $history[1]'

abbr -a fconf 'cd ~/dotfiles/.config/fish/ ; ls'
abbr -a sourcefish '. ~/.config/fish/config.fish'
abbr -a editabbr 'vim -p ~/.config/fish/my-abbreviations.fish; source ~/.config/fish/my-abbreviations.fish'
abbr -a vd 'vimdiff'
abbr -a fn 'functions'
abbr -a fns 'functions'

abbr -a o 'open .'
abbr -a find 'find . -iname'
abbr -a fnd 'find . -iname'
abbr -a f 'find . -iname'
abbr -a fr 'find -E . -iregex'
abbr -a fnd1 'find . -maxdepth 1 -iname'
abbr -a tree 'tree -C -a'
abbr -a tre 'tree -C -a'
abbr -a t3 'tree -C -a -L 3'
abbr -a t3d 'tree -C -a -L 3 -d'
abbr -a v 'vim -p'
abbr -a t 'tig'
abbr -a r 'ranger'
abbr -a s 'sublime'
abbr -a e 'vim -R "+normal :Explore\$" .'
abbr -a gitup 'pwd ; cd (git rev-parse --show-toplevel)'
abbr -a gitp  'pwd ; cd (git rev-parse --show-toplevel)'
abbr -a ccat 'pygmentize -O style=native -f console256 -g'
abbr -a cct 'pygmentize -O style=native -f console256 -g'
abbr -a xcode 'open -a Xcode'
abbr -a xc 'open -a Xcode'
abbr -a bpython '/usr/bin/python -m bpython' # makes my bpython point to my own python version      (160817: 2.7.11)
abbr -a bp '/usr/bin/python -m bpython'      # makes my bpython point to my own python version      (160817: 2.7.11)
abbr -a chrome 'open -a "Google Chrome"'
abbr -a crm 'open -a "Google Chrome"'

abbr -a vimh "vim -p (eval $history[1])"
abbr -a oh "open (eval $history[1])"
abbr -a ohf "open -R (eval $history[1])"

abbr -a jrn 'journal \''
abbr -a j 'journal \''
abbr -a mnm 'minimerk \''
#abbr -a m 'minimerk \''
abbr -a bkt 'bucket \''
abbr -a b 'bucket \''
abbr -a tks 'tricks'
abbr -a editjrn "vim -R \"+normal G\\\$\" -p $STUFF_DIR/Journal.txt"
abbr -a olh 'one-line-help'
abbr -a alh 'add-to-one-line-help \''

abbr -a cd.. 'cd ..'
abbr -a c. 'cd ..'
abbr -a cd. 'cd ..'

# grep -Hirns - like abbreviations
abbr -a h 'grep-hirns'
abbr -a g 'grep'
abbr -a hI 'grep-HirnsI'
abbr -a c 'grep-hirns-for-cstyle-files'
abbr -a fh 'grep-hirns-for-franca-files'
abbr -a ca 'grep -Hirns --exclude-dir=.git --include \*.h --include \*.hpp --include \*.cpp --include \*.m --include \*.mm --include \*.pch --include \*.java --include \*.swift --include \*.cc --include \*.kt --color'
abbr -a cmh 'grep-hirns-for-cmake-files'
abbr -a jh 'grep-hirns-for-java-kotlin-files'
abbr -a ph 'grep-hirns-for-python-files'

abbr -a gs 'git status'
abbr -a gl 'git log'
abbr -a gbl 'git blame'
abbr -a gb 'git branch'
abbr -a gbr 'git branch -r'
abbr -a gca 'git commit --amend'
abbr -a gss 'git stash'
abbr -a gsa 'git stash apply'

abbr -a gco 'git checkout'
abbr -a gcs 'git checkout staging'
abbr -a gcos 'git checkout staging'
abbr -a gcm 'git checkout master'
abbr -a gcom 'git checkout master'

abbr -a gcb 'git checkout -b'
abbr -a gbn 'git checkout -b'
abbr -a gnb 'git checkout -b'

abbr -a gbd 'git branch -D'

abbr -a gps 'git push origin HEAD:refs/for/staging'
abbr -a gpm 'git push origin HEAD:refs/for/master'

abbr -a gpl 'git pull --rebase origin'
abbr -a gpls 'git pull --rebase origin staging'
abbr -a gplm 'git pull --rebase origin master'

abbr -a gri 'git rebase --interactive HEAD~10'
abbr -a grc 'git rebase --continue'
abbr -a gra 'git rebase --abort'

abbr -a grsh 'git reset --soft HEAD~1'
abbr -a grhh 'git reset --hard HEAD'
abbr -a grhh1 'git reset --hard HEAD~1'
abbr -a grhh9 'git reset --hard HEAD~9'
abbr -a grh9 'git reset --hard HEAD~9'
abbr -a gfm 'git commit -a -m "TODO Save my work, just in case"; git branch my-saved-work-(date "+%Y-%m-%d--%H-%M-%S") ; git fetch origin ; git reset --hard origin/master'

abbr -a gitgrep 'git log -p --color-words -S'

abbr -a rd 'repo diff'
abbr -a rps 'repo sync -c -j8'
abbr -a rpc 'repo status ; repo diff ; repo forall -c "printf \"\033[1;36m`git rev-parse --show-toplevel`\033[0m\t`git log -n1 --pretty=format:\"%an\t%s\"`\" | grep \"Langenhagen\""'
abbr -a sfr "git review master --reviewers (git log -n40 --pretty=format:'%ae' | sort | uniq -c | sort -nr | awk '{print \$2}' | head -8)"
abbr -a foldmsg 'grep -v "^#" (git rev-parse --show-toplevel)/.git/COMMIT_EDITMSG | fold -s -w 72 | sed \'s/[ \t]*$//\' > (git rev-parse --show-toplevel)/.git/COMMIT_EDITMSG;'

abbr -a rmlines 'sed -i \'/ \/rm/d\' (git diff --name-only HEAD)'

abbr -a proto 'cd "$PROTOFILES_DIR_PATH" ; find "$PROTOFILES_DIR_PATH" -name "*_proto.*"'
abbr -a prt 'cd "$PROTOFILES_DIR_PATH" ; find "$PROTOFILES_DIR_PATH" -name "*_proto.*"'
abbr -a play 'cd "$PLAYGROUND_DIR_PATH" ; find "$PLAYGROUND_DIR_PATH" -type d -maxdepth 1 -not -path "*/\.*" -name "*"'
abbr -a ply 'cd "$PLAYGROUND_DIR_PATH" ; find "$PLAYGROUND_DIR_PATH" -type d -maxdepth 1 -not -path "*/\.*" -name "*"'

abbr -a bta 'cd ~/code/sparta/ ; and ./scripts/build/android --cmake-build-prefix build --android-abi arm64-v8a ; and ./scripts/build/swift --xcode-sdk iphoneos --cmake-build-prefix build --xcode-simulator ; and cd build/build-swift-iphoneos_x86/ ; and xcodebuild -target ivi_mobile_sdk_test_cpp ; and cd ~/code/sparta/corenav/sdk/ ; and ./gradlew testDebug'  # build test all or bitch test all
abbr -a bra 'cd ~/code/sparta/apps/android-reference/ ; ./gradlew :mobile:installDebug ; and adb shell am start -n com.here.ivi.reference.debug/com.here.ivi.reference.overview.OverviewActivity'  # build run android application

