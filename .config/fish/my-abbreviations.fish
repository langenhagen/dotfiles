# this file contains custom fish abbreviations
#
# author: langenhagen
# version: 2017-10-16
#

## evergreen abbreviations

abbr -a cd.. cd ..
abbr -a c. cd ..
abbr -a c cd ..
abbr -a cdd cd ~/Desktop
abbr -a cddotfiles cd /Users/langenha/dotfiles

abbr -a cdcode cd $CODE_DIR
abbr -a ccode cd $CODE_DIR
abbr -a cdcde cd $CODE_DIR
abbr -a cddocker cd $CODE_DIR/docker
abbr -a cdocker cd $CODE_DIR/docker
abbr -a cdscripts cd $SCRIPTS_DIR
abbr -a cscripts cd $SCRIPTS_DIR
abbr -a cdstuff cd $HOME/stuff
abbr -a cstuff cd $HOME/stuff
abbr -a cds cd $HOME/stuff

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

abbr -a cdapihw cd /Users/langenha/code/api-prime/projects/hello_world/
abbr -a capihw cd /Users/langenha/code/api-prime/projects/hello_world/
abbr -a cdapi cd /Users/langenha/code/api-prime/
abbr -a capi cd /Users/langenha/code/api-prime/
abbr -a cdtp cd /Users/langenha/code/api-prime/api-transpiler/
abbr -a ctp cd /Users/langenha/code/api-prime/api-transpiler/

abbr -a gs git status
abbr -a gb git branch
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

## later added abbreviations

abbr -a cahw /Users/langenha/code/api-prime/projects/hello_world/



