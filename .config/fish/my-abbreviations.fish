# this file contains custom fish abbreviations
#
# author: langenhagen
# version: 2017-10-16
#

abbr -a fishconfig vim ~/.config/fish/config.fish
abbr -a fconf vim ~/.config/fish/config.fish
abbr -a fic vim ~/.config/fish/config.fish
abbr -a sourcefish . ~/.config/fish/config.fish
abbr -a srcf . ~/.config/fish/config.fish
abbr -a editabbr vim -p ~/.config/fish/my-abbreviations.fish

abbr -a jrn journal
abbr -a bkt bucket
abbr -a tks tricks
abbr -a editjrn 'vim -R "+normal G\$" -p $STUFF_DIR/Journal.txt'
abbr -a ej 'vim -R "+normal G\$" -p $STUFF_DIR/Journal.txt'
abbr -a gitp gitup
abbr -a e 'vim -R "+normal :Explore\$" .'

abbr -a cd.. cd ..
abbr -a c. cd ..
abbr -a c cd ..
abbr -a cdd cd ~/Desktop
abbr -a cddotfiles cd ~/dotfiles

abbr -a cdcode cd $CODE_DIR
abbr -a ccode cd $CODE_DIR
abbr -a cdcde cd $CODE_DIR
abbr -a cdscripts cd $SCRIPTS_DIR
abbr -a cscripts cd $SCRIPTS_DIR
abbr -a cdstuff cd $STUFF_DIR
abbr -a cstuff cd $STUFF_DIR
abbr -a cds cd $STUFF_DIR

abbr -a opn open .
abbr -a o open .
abbr -a find find . -iname
abbr -a fnd find . -iname
abbr -a fnd1 find . -iname -maxdepth 1
abbr -a t3 tree -L 3
abbr -a t3d tree -L 3 -d


abbr -a vim vim -p
abbr -a v vim -p
abbr -a tg tig
abbr -a t tig
abbr -a sb sublime
abbr -a xcode open -a Xcode
abbr -a xc open -a Xcode
abbr -a bpython '/usr/local/bin/python -m bpython' # makes my bpython point to my own python version      (160817: 2.7.11)
abbr -a bp '/usr/local/bin/python -m bpython'      # makes my bpython point to my own python version      (160817: 2.7.11)
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
abbr -a grhh10 git reset --hard HEAD~10

abbr -a rd repo diff
abbr -a rps repo sync -j8

abbr -a mrc 'repo forall -c "printf \"\033[1;36m`git rev-parse --show-toplevel`\033[0m\t`git log -n1 --pretty=format:\"%an\t%s\"`\" | grep \"Langenhagen\"" # My Repo Changes : show lastest repo commits if they are mine'


abbr -a cdapihw cd ~/code/api-prime/projects/hello_world/
abbr -a capihw cd ~/code/api-prime/projects/hello_world/
abbr -a cdapi cd ~/code/api-prime/
abbr -a capi cd ~/code/api-prime/
abbr -a cdtp cd ~/code/api-prime/api-transpiler/
abbr -a ctp cd ~/code/api-prime/api-transpiler/

abbr -a cahw cd ~/code/api-prime/projects/hello_world/

abbr -a csp cd ~/code/sparta/
abbr -a crnvsdk cd ~/code/sparta/corenav/sdk/
abbr -a cnvsdk cd ~/code/sparta/corenav/sdk/
abbr -a cdsparta cd ~/code/sparta/
abbr -a csparta cd ~/code/sparta/abbr -a cnv cd /Users/langenha/code/sparta/corenav/
