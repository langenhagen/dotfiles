# this file contains custom fish abbreviations
#
# author: langenhagen
# version: 2018-05-17
#

abbr -a fishconfig vim ~/.config/fish/config.fish
abbr -a fconf 'cd /Users/langenha/dotfiles/.config/fish/ ; ls'
abbr -a cfconf 'cd /Users/langenha/dotfiles/.config/fish/ ; ls'
abbr -a fic vim ~/.config/fish/config.fish
abbr -a sourcefish . ~/.config/fish/config.fish
abbr -a srcf . ~/.config/fish/config.fish
abbr -a editabbr vim -p ~/.config/fish/my-abbreviations.fish
abbr -a ea vim -p ~/.config/fish/my-abbreviations.fish
abbr -a vd vimdiff
abbr -a fns functions

# maybe rather get output of last command instead of invoking the same command...
abbr -a vimh "vim -p (eval $history[1])"
abbr -a oh "open (eval $history[1])"
abbr -a ohf "open -R (eval $history[1])"

abbr -a jrn 'journal "'
abbr -a mnm 'minimerk "'
abbr -a bkt 'bucket "'
abbr -a tks tricks
abbr -a editjrn 'vim -R "+normal G\$" -p $STUFF_DIR/Journal.txt'
abbr -a ej 'vim -R "+normal G\$" -p $STUFF_DIR/Journal.txt'
abbr -a gitup 'pwd ; cd (git rev-parse --show-toplevel)'
abbr -a gitp  'pwd ; cd (git rev-parse --show-toplevel)'
abbr -a e 'vim -R "+normal :Explore\$" .'

abbr -a cd.. cd ..
abbr -a c. cd ..
abbr -a c cd ..
abbr -a cdd cd ~/Desktop
abbr -a cdotfiles cd ~/dotfiles

abbr -a cdcode cd $CODE_DIR
abbr -a ccode cd $CODE_DIR
abbr -a cdcde cd $CODE_DIR
abbr -a ccd cd $CODE_DIR
abbr -a cdscripts cd $SCRIPTS_DIR
abbr -a cscripts cd $SCRIPTS_DIR
abbr -a cdstuff cd $STUFF_DIR
abbr -a cstuff cd $STUFF_DIR
abbr -a cds cd $STUFF_DIR

abbr -a opn open .
abbr -a o open .
abbr -a find find . -iname
abbr -a fnd find . -iname
abbr -a fnd1 find . -maxdepth 1 -iname
abbr -a t3 tree -L 3
abbr -a t3d tree -L 3 -d

# chrn - like abbreviations
abbr -a chra "grep -Hirns --exclude-dir=.git --include \*.h --include \*.hpp --include \*.cpp --include \*.m --include \*.mm --include \*.pch --include \*.java --include \*.swift --include \*.cc --include \*.kt --color"

#abbr -a vim vim -p
abbr -a v vim -p
abbr -a t tig
abbr -a s sublime
abbr -a xcode open -a Xcode
abbr -a xc open -a Xcode
abbr -a bpython '/usr/bin/python -m bpython' # makes my bpython point to my own python version      (160817: 2.7.11)
abbr -a bp '/usr/bin/python -m bpython'      # makes my bpython point to my own python version      (160817: 2.7.11)
abbr -a chrome open -a \"Google Chrome\"
abbr -a crm open -a \"Google Chrome\"

abbr -a gs git status
abbr -a gl git log
abbr -a gbl git blame
abbr -a gb git branch
abbr -a gbr git branch -r
abbr -a gca git commit --amend
abbr -a gss git stash
abbr -a gsa git stash apply

abbr -a gco git checkout
abbr -a gcs git checkout staging
abbr -a gcos git checkout staging
abbr -a gcm git checkout master
abbr -a gcom git checkout master

abbr -a gcob git checkout -b
abbr -a gcb git checkout -b
abbr -a gbn git checkout -b
abbr -a gnb git checkout -b

abbr -a gbd git branch -D

abbr -a gps git push origin HEAD:refs/for/staging
abbr -a gpm git push origin HEAD:refs/for/master

abbr -a gpl git pull --rebase origin
abbr -a gpls git pull --rebase origin staging
abbr -a gplm git pull --rebase origin master

abbr -a gri git rebase --interactive HEAD~10
abbr -a grc git rebase --continue
abbr -a gra git rebase --abort

abbr -a grhh git reset --hard HEAD
abbr -a grsh git reset --soft HEAD~1
abbr -a grhh9 git reset --hard HEAD~9
abbr -a gfm 'git commit -a -m "TODO Save my work, just in case"; git branch my-saved-work-(date "+%Y-%m-%d--%H-%M-%S") ; git fetch origin ; git reset --hard origin/master'

abbr -a rd repo diff
abbr -a rps repo sync -c -j8
abbr -a rpc 'repo status ; repo diff ; repo forall -c "printf \"\033[1;36m`git rev-parse --show-toplevel`\033[0m\t`git log -n1 --pretty=format:\"%an\t%s\"`\" | grep \"Langenhagen\""'
abbr -a sfr "git review master --reviewers (git log -n40 --pretty=format:'%ae' | sort | uniq -c | sort -nr | awk '{print \$2}' | head -8)"

abbr -a cmh cmhr

abbr -a proto 'cd /Users/langenha/personal/Dev/_Protofiles ; find /Users/langenha/personal/Dev/_Protofiles -name "*_proto.*"'
abbr -a play 'cd /Users/langenha/personal/Dev/_playgrounds ; find /Users/langenha/personal/Dev/_Protofiles -type d -maxdepth 1 -not -path "*/\.*" -name "*"'
abbr -a ply 'cd /Users/langenha/personal/Dev/_playgrounds ; find /Users/langenha/personal/Dev/_playgrounds -type d -maxdepth 1 -not -path "*/\.*" -name "*"'

abbr -a cdapihw cd ~/code/api-prime/projects/hello_world/
abbr -a capihw cd ~/code/api-prime/projects/hello_world/
abbr -a cdapi cd ~/code/api-prime/
abbr -a capi cd ~/code/api-prime/
abbr -a cdtp cd ~/code/api-prime/api-transpiler/
abbr -a ctp cd ~/code/api-prime/api-transpiler/
abbr -a cahw cd ~/code/api-prime/projects/hello_world/
abbr -a csp cd ~/code/sparta/
abbr -a cnv cd /Users/langenha/code/sparta/corenav/sdk/
abbr -a caa cd /Users/langenha/code/sparta/apps/android-reference/
abbr -a cai cd /Users/langenha/code/sparta/apps/ios-reference/

abbr -a i "echo (date +%a' '%Y'-'%m'-'%d' '%H:%M) $argv >> ~/stuff/_yellow_cards/sascha_p//times_sascha-interrupted-people.txt ; echo '.'"
abbr -a cpt cd /Users/langenha/code/sparta/scripts/build/
abbr -a cl colorize-output-lines.sh
