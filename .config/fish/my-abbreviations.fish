# this file contains custom fish abbreviations
#
# author: langenhagen
# version: 2018-07-24
#

abbr -a fconf 'cd ~/dotfiles/.config/fish/ ; ls'
abbr -a sourcefish '. ~/.config/fish/config.fish'
abbr -a editabbr 'vim -p ~/.config/fish/my-abbreviations.fish; source ~/.config/fish/my-abbreviations.fish'
abbr -a vd 'vimdiff'
abbr -a fn 'functions'
abbr -a fns 'functions'

abbr -a vimh "vim -p (eval $history[1])"
abbr -a oh "open (eval $history[1])"
abbr -a ohf "open -R (eval $history[1])"

abbr -a jrn 'journal \''
abbr -a j 'journal \''
abbr -a mnm 'minimerk \''
abbr -a m 'minimerk \''
abbr -a bkt 'bucket \''
abbr -a b 'bucket \''
abbr -a tks 'tricks'
abbr -a editjrn "vim -R \"+normal G\\\$\" -p $STUFF_DIR/Journal.txt"
abbr -a olh 'one-line-help'
abbr -a alh 'add-to-one-line-help'

abbr -a gitup 'pwd ; cd (git rev-parse --show-toplevel)'
abbr -a gitp  'pwd ; cd (git rev-parse --show-toplevel)'
abbr -a e 'vim -R "+normal :Explore\$" .'
abbr -a cl 'colorize-output-lines.sh'
abbr -a ccat 'pygmentize -O style=native -f console256 -g'
abbr -a cct 'pygmentize -O style=native -f console256 -g'

abbr -a cd.. 'cd ..'
abbr -a c. 'cd ..'
abbr -a cdd 'cd ~/Desktop'
abbr -a cdotfiles 'cd ~/dotfiles'
abbr -a cdt 'cd ~/dotfiles'
abbr -a cdtf 'cd ~/dotfiles'

abbr -a cdcode "cd $CODE_DIR"
abbr -a ccode "cd $CODE_DIR"
abbr -a cdcde "cd $CODE_DIR"
abbr -a ccd "cd $CODE_DIR"
abbr -a cdscripts "cd $SCRIPTS_DIR"
abbr -a cscripts "cd $SCRIPTS_DIR"
abbr -a cdstuff "cd $STUFF_DIR"
abbr -a cstuff "cd $STUFF_DIR"
abbr -a cds "cd $STUFF_DIR"

abbr -a o 'open .'
abbr -a find 'find . -iname'
abbr -a fnd 'find . -iname'
abbr -a fnd1 'find . -maxdepth 1 -iname'
abbr -a t3 'tree -L 3'
abbr -a t3d 'tree -L 3 -d'

# grep -Hirns - like abbreviations
abbr -a h 'grep-hirns'
abbr -a hI 'grep-HirnsI'
abbr -a c 'grep-hirns-for-cstyle-files'
abbr -a ca 'grep -Hirns --exclude-dir=.git --include \*.h --include \*.hpp --include \*.cpp --include \*.m --include \*.mm --include \*.pch --include \*.java --include \*.swift --include \*.cc --include \*.kt --color'
abbr -a cmh 'grep-hirns-for-cmake-files'
abbr -a jh 'grep-hirns-for-java-kotlin-files'
abbr -a ph 'grep-hirns-for-python-files'

abbr -a v 'vim -p'
abbr -a t 'tig'
abbr -a r 'ranger'
abbr -a s 'sublime'
abbr -a xcode 'open -a Xcode'
abbr -a xc 'open -a Xcode'
abbr -a bpython '/usr/bin/python -m bpython' # makes my bpython point to my own python version      (160817: 2.7.11)
abbr -a bp '/usr/bin/python -m bpython'      # makes my bpython point to my own python version      (160817: 2.7.11)
abbr -a chrome 'open -a "Google Chrome"'
abbr -a crm 'open -a "Google Chrome"'

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
abbr -a gcob 'git checkout -b'
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

abbr -a grhh 'git reset --hard HEAD'
abbr -a grsh 'git reset --soft HEAD~1'
abbr -a grhh9 'git reset --hard HEAD~9'
abbr -a gfm 'git commit -a -m "TODO Save my work, just in case"; git branch my-saved-work-(date "+%Y-%m-%d--%H-%M-%S") ; git fetch origin ; git reset --hard origin/master'

abbr -a gitgrep 'git log -p --color-words -S'

abbr -a rd 'repo diff'
abbr -a rps 'repo sync -c -j8'
abbr -a rpc 'repo status ; repo diff ; repo forall -c "printf \"\033[1;36m`git rev-parse --show-toplevel`\033[0m\t`git log -n1 --pretty=format:\"%an\t%s\"`\" | grep \"Langenhagen\""'
abbr -a sfr "git review master --reviewers (git log -n40 --pretty=format:'%ae' | sort | uniq -c | sort -nr | awk '{print \$2}' | head -8)"

abbr -a rmlines 'sed -i \'/ \/rm/d\' (git diff --name-only HEAD)'

abbr -a proto 'cd ~/personal/Dev/_Protofiles ; find ~/personal/Dev/_Protofiles -name "*_proto.*"'
abbr -a prt 'cd ~/personal/Dev/_Protofiles ; find ~/personal/Dev/_Protofiles -name "*_proto.*"'
abbr -a play 'cd ~/personal/Dev/_playgrounds ; find ~/personal/Dev/_Protofiles -type d -maxdepth 1 -not -path "*/\.*" -name "*"'
abbr -a ply 'cd ~/personal/Dev/_playgrounds ; find ~/personal/Dev/_playgrounds -type d -maxdepth 1 -not -path "*/\.*" -name "*"'

abbr -a capi 'cd ~/code/api-prime/'
abbr -a cdtp 'cd ~/code/api-prime/api-transpiler/'
abbr -a ctp 'cd ~/code/api-prime/api-transpiler/'
abbr -a cahw 'cd ~/code/api-prime/projects/hello_world/'
abbr -a csp 'cd ~/code/sparta/'
abbr -a cnv 'cd ~/code/sparta/corenav/sdk/'
abbr -a caa 'cd ~/code/sparta/apps/android-reference/'
abbr -a cai 'cd ~/code/sparta/apps/ios-reference/'
abbr -a csb 'cd ~/code/sparta/scripts/build/'
