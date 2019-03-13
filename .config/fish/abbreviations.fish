# This file contains custom fish abbreviations.
#
# Apparently, fish does not support transitive abbreviations, i.e. abbreviations used within
# abbreviations will not be expandend.
#
# author: andreasl

switch (uname -n)
case "barn-ultra" "*celeraone*"
    # Desktop Machine Related abbrs

    abbr -a now 'date \'+%s\' | xclip -fi -selection clipboard'  # the current timestamp since epoch in seconds

    abbr -a proto 'cd "$PROTOFILES_DIR_PATH" ; find "$PROTOFILES_DIR_PATH" -name "*_proto.*"'
    abbr -a prt 'cd "$PROTOFILES_DIR_PATH" ; find "$PROTOFILES_DIR_PATH" -name "*_proto.*"'
    abbr -a play 'cd "$PLAYGROUND_DIR_PATH" ; find "$PLAYGROUND_DIR_PATH" -maxdepth 1 -type d -not -path "*/\.*" -name "*"'
    abbr -a ply 'cd "$PLAYGROUND_DIR_PATH" ; find "$PLAYGROUND_DIR_PATH" -maxdepth 1 -type d -not -path "*/\.*" -name "*"'

    abbr -a jrn 'journal \''
    abbr -a j 'journal \''
    abbr -a editjrn "vim -R '+normal G\$' -p $JOURNAL_FILE_PATH"
    abbr -a bkt 'bucket \''
    abbr -a b 'bucket \''
    abbr -a tks 'tricks'
    abbr -a olh 'one-line-help'
    abbr -a alh 'add-to-one-line-help \''

    abbr -a s 'subl'
    abbr -a xs 'xargs subl'
    abbr -a sh "subl (eval \$history[1])"

    switch (uname)
    # OS dependent abbrs
    case  'Darwin'
        abbr -a xcode 'open -a Xcode'
        abbr -a xc 'open -a Xcode'
        abbr -a o 'open .'
        abbr -a oh "open (eval \$history[1])"

    case  'Linux'
        abbr -a open 'xdg-open'
        abbr -a xo 'xargs xdg-open'
        abbr -a o 'xdg-open .'
        abbr -a oh "for f in (eval \$history[1]); xdg-open \"\$f\"; end"
        abbr -a xh "eval \$history[1] | xclip -fi -selection primary | xclip -fi -selection clipboard > ~/.histout"
        abbr -a ho "eval \$history[1] | xclip -fi -selection primary | xclip -fi -selection clipboard > ~/.histout"
        abbr -a go "eval \$history[1] | sed 's|\(.+*\):[0-9]*:.*|\1|' | sed '/^Binary file.*matches\$/d' | sort | uniq | xclip -fi -selection primary | xclip -fi -selection clipboard | tee ~/.histout"

        abbr -a pbcopy 'xclip -selection clipboard'
        abbr -a pbpaste 'xclip -selection clipboard -o'
    end
end

abbr -a fconf 'cd ~/.config/fish/ ; ls'
abbr -a sourcefish '. ~/.config/fish/config.fish'
abbr -a editabbr 'vim -p ~/.config/fish/abbreviations.fish; source ~/.config/fish/abbreviations.fish'
abbr -a fn 'functions'
abbr -a fns 'functions'

abbr -a tmls 'tmux ls'
abbr -a tmk 'tmux kill-session -t'
abbr -a tmw 'tmux kill-window -t'

abbr -a cd.. 'cd ..'
abbr -a c. 'cd ..'
abbr -a cd. 'cd ..'

abbr -a !! 'eval \$history[1]'
abbr -a xi 'cat ~/.histout'
abbr -a hi 'cat ~/.histout'

abbr -a 'trenn' 'for i in (seq (tput cols)); printf \'\\e[31m=\'; end; printf \'\\e[m\n\''
abbr -a mnm 'minimerk \''

abbr -a vh "vim -p (eval \$history[1])"
abbr -a vd 'vimdiff'

abbr -a xo 'xargs open'
abbr -a xv 'xargs -o vim -p'  # xargs -o: Reopen stdin as /dev/tty in the child process before executing the command
abbr -a xx 'xargs -o vim -p'  # xargs -o: Reopen stdin as /dev/tty in the child process before executing the command

abbr -a f 'find -L . -iname'
abbr -a fr 'find -L -E . -iregex'
abbr -a f1 'find -L . -maxdepth 1 -iname'
abbr -a tree 'tree -C -a'
abbr -a tre 'tree -C -a'
abbr -a t3 'tree -C -a -L 3'
abbr -a t3d 'tree -C -a -L 3 -d'
abbr -a v 'vim -p'
abbr -a t 'tig'
abbr -a tb 'tig blame'
abbr -a ts 'tig show'
abbr -a r 'ranger'
abbr -a e 'vim -R "+normal :Explore\$" .'
abbr -a gitp  'pwd ; cd (git rev-parse --show-toplevel)'  # abbreviation for GituP
abbr -a cct 'pygmentize -O style=native -f console256 -g'
abbr -a bp 'bpython'
abbr -a json 'json_pp'  # pretty-print json output

abbr -a g 'grep'
abbr -a h 'grep -HiRns'
abbr -a ch 'grep -HiRns --include={\*.h,\*.hpp,\*.c,\*.cpp,\*.cc,\*.m,\*.mm,\*.pch,\*.java,\*.swift,\*.kt}'
abbr -a cmh 'grep -HiRns --include={CMakeCache.txt,CMakeLists.txt,\*.cmake}'
abbr -a ph 'grep -HiRns --include=\*.py'
abbr -a lh 'grep -HiRns --include=\*.lua'
abbr -a rh 'grep -HiRns --include=\*.robot'
abbr -a cfh 'grep -HiRns --include={\*.cfg,setup.py,requirements.txt,Makefile}'

abbr -a gs 'git status --short --branch --untracked-files'
abbr -a gl 'git log --stat'
abbr -a gbl 'git blame -n'
abbr -a gb 'git branch'
abbr -a gbr 'git branch -r'
abbr -a gca 'git commit --amend'
abbr -a gss 'git stash'
abbr -a gsa 'git stash apply'

abbr -a gco 'git checkout'
abbr -a gcm 'git checkout master'
abbr -a gcom 'git checkout master'
abbr -a gm 'git checkout master'

abbr -a gbn 'git checkout -b'
abbr -a gnb 'git checkout -b'

abbr -a gbd 'git branch -D'

abbr -a gbt 'git checkout -b tmp; or git checkout tmp; git branch'  # git branch tmp
abbr -a gct 'git checkout -b tmp; or git checkout tmp; git branch'  # git checkout tmp
abbr -a gdt 'git checkout master; git branch -D tmp; git branch'   # git delete tmp

abbr -a gpm 'git push origin HEAD:master'
abbr -a gprm 'git push origin HEAD:refs/for/master'

abbr -a gp 'git pull --rebase'
abbr -a gpl 'git pull --rebase'
abbr -a gplm 'git pull --rebase origin master'

abbr -a gri 'git rebase --interactive HEAD~10'
abbr -a grc 'git rebase --continue'
abbr -a gra 'git rebase --abort'

abbr -a grsh 'git reset --soft HEAD~1'
abbr -a grhh 'git reset --hard HEAD'
abbr -a grh1 'git reset --hard HEAD~1'
abbr -a grh2 'git reset --hard HEAD~2'
abbr -a grh3 'git reset --hard HEAD~3'
abbr -a grh4 'git reset --hard HEAD~4'
abbr -a grh5 'git reset --hard HEAD~5'
abbr -a grh9 'git reset --hard HEAD~9'

abbr -a ccr 'conda create --name tmp python=3.7 pip'
abbr -a cr 'conda remove -y --all --name'

abbr -a w 'workon'
abbr -a workoff 'conda deactivate'

abbr -a gitgrep 'git log -p --color-words -S'

abbr -a rps 'repo sync -c -j8'
abbr -a rpc 'repo status ; repo diff ; repo forall -c "printf \"\033[1;36m`git rev-parse --show-toplevel`\033[0m\t`git log -n1 --pretty=format:\"%an\t%s\"`\" | grep \"Langenhagen\""'

abbr -a gr 'git review -d'
abbr -a sfr "git review master --reviewers (git log -n40 --pretty=format:'%ae' | sort | uniq -c | sort -nr | awk '{print \$2}' | head -8)"

switch (uname -n)
case  "*celeraone*"
    # C1 related abbrs
    abbr -a qq 'cd ~/c1'
    abbr -a q 'cd-into-c1-project'
    abbr -a qa 'cd-into-c1-project authservice'
    abbr -a qap 'cd-into-c1-project authproxy'
    abbr -a qc 'cd-into-c1-project cre-api'
    abbr -a qe 'cd-into-c1-project entitlement'
    abbr -a qex 'cd-into-c1-project exceptions'
    abbr -a qf 'cd-into-c1-project frontend'
    abbr -a ql 'cd-into-c1-project lua'
    abbr -a qm 'cd-into-c1-project metrics'
    abbr -a qo 'cd-into-c1-project openid'
    abbr -a qp 'cd-into-c1-project pueblo'
    abbr -a qs 'cd-into-c1-project scheduler'

    abbr -a gpa 'find $HOME/c1 -type d -iname "*.git" -execdir bash -c \'printf "\033[1m${PWD}\033[0m\n"; git pull --rebase;\' \;'
    abbr -a sco 'cd ~/c1; find . -type d -iname "*.git" -execdir bash -c \'printf "\033[1m${PWD}\033[0m\n"; git pull --rebase;\' \;'
    abbr -a fap 'pull-rebase-all-repos.sh'
    abbr -a fas 'cd; ~/c1; forall-git-dirs.sh -q -d 2 -- \'printf "$PWD"; printf "%0.s~" $(seq ${#PWD} 45); git status -sbu\''
    abbr -a fa 'cd ~/c1; forall-git-dirs.sh -d 2 --'

    abbr -a cre 'http --auth-type c1-auth -a'
    abbr -a og 'xdg-open "https://codereview.celeraone.com/dashboard/self"' # open gerrit
    abbr -a oj 'xdg-open "https://jira.celeraone.com/secure/Dashboard.jspa?selectPageId=11405"'  # open jira
    abbr -a cj 'xdg-open "https://jira.celeraone.com/secure/CreateIssue!default.jspa"'  # create jira ticket
    abbr -a rl 'xdg-open "var/log/testreports/log.html"'  # robot log
end
