# This file contains custom fish abbreviations.
#
# Apparently, fish does not support transitive abbreviations, i.e. abbreviations used within
# abbreviations will not be expandend.
#
# Adding more abbreviations may increase the fish loading time on slow machines considerably.
# Therefore, some less used abbreviations are commented out. I plan to remove them after 1 year
# without need of use.
#
# author: andreasl

abbr -a fconf 'cd ~/.config/fish/ ; ls'
abbr -a sourcefish '. ~/.config/fish/config.fish'
abbr -a editabbr 'vim -p ~/.config/fish/abbreviations.fish; source ~/.config/fish/abbreviations.fish'
abbr -a fn 'functions'
abbr -a fns 'functions'
abbr -a history 'history --show-time=\'%h-%d - %H:%M:%S \' | less'
abbr -a he 'eval (history | fzf)'

abbr -a tmls 'tmux ls'
abbr -a tmk 'tmux kill-session -t'
abbr -a tmw 'tmux kill-window -t'

abbr -a c. 'cd ..'
abbr -a cd. 'cd ..'
abbr -a cd.. 'cd ..'

abbr -a !! 'eval \$history[1]'
abbr -a hi 'cat ~/.histout'

abbr -a cls 'clear'
abbr -a mnm 'minimerk \''
abbr -a trenn 'for i in (seq (tput cols)); printf \'\\e[31m=\'; end; printf \'\\e[m\n\''
abbr -a gsl 'fish $SCRIPTS_DIR_PATH/grepselect.fish'

abbr -a b 'bash'
abbr -a p 'python'
abbr -a bp 'bpython'
abbr -a cct 'vim --cmd \'set t_ti= t_te=\' +redraw +q'
abbr -a gitp  'pwd ; cd (git rev-parse --show-toplevel)'  # abbreviation for GituP
abbr -a json 'json_pp'  # pretty-print json output
abbr -a r 'ranger'
abbr -a shch 'shellcheck --exclude SC2059'
abbr -a vd 'vimdiff'
abbr -a wcl 'wc -l'

abbr -a f 'find -L . -iname'
#abbr -a f1 'find -L . -maxdepth 1 -iname'    # commented out before Tuesday, 26 March 2019
#abbr -a fr 'find -L -E . -iregex'    # commented out before Tuesday, 26 March 2019

abbr -a t 'tig'
abbr -a tb 'tig blame'
abbr -a ts 'tig show'

abbr -a tree 'tree -C -a'
abbr -a tre 'tree -C -a'
abbr -a t3 'tree -C -a -L 3'
abbr -a t3d 'tree -C -a -L 3 -d'

abbr -a v 'vim -p'
abbr -a vh "vim -p (eval \$history[1])"
abbr -a e 'vim -R "+normal :Explore\$" .'

abbr -a xv 'xargs -o vim -p'  # xargs -o: Reopen stdin as /dev/tty in the child process before executing the command
abbr -a xx 'xargs -o vim -p'  # xargs -o: Reopen stdin as /dev/tty in the child process before executing the command

abbr -a g 'grep'
abbr -a h 'grep -HiRns'
abbr -a ch 'grep -HiRns --include={\*.h,\*.hpp,\*.c,\*.cpp,\*.cc,\*.m,\*.mm,\*.pch,\*.java,\*.swift,\*.kt}'
abbr -a cmh 'grep -HiRns --include={CMakeCache.txt,CMakeLists.txt,\*.cmake}'
abbr -a ph 'grep -HiRns --include=\*.py --exclude-dir={.venv\*,custom-eggs}'
abbr -a lh 'grep -HiRns --include=\*.lua'
abbr -a rh 'grep -HiRns --include=\*.robot'
abbr -a cfh 'grep -HiRns --include={\*.cfg,setup.py,requirements.txt,Makefile}'

#abbr -a gca 'git commit --amend' Commented out on Sunday, April 7, 2019
abbr -a gb 'git branch'
abbr -a gbl 'git blame -n'
abbr -a gbr 'git branch -r'
abbr -a gcl 'git clean -dxf'
abbr -a gl 'git log --stat'
abbr -a grv 'git remote -v'
abbr -a gs 'git status --short --branch --untracked-files'
abbr -a gsp 'git stash pop'
abbr -a gss 'git stash'

abbr -a gco 'git checkout'
abbr -a gcm 'git checkout master'
abbr -a gcom 'git checkout master'
abbr -a gm 'git checkout master'

abbr -a gbn 'git checkout -b'
abbr -a gnb 'git checkout -b'

abbr -a gbd 'git branch -D'

abbr -a gbt 'git checkout -b tmp; or git checkout tmp; git branch'  # git branch tmp
abbr -a gct 'git checkout -b tmp; or git checkout tmp; git branch'  # git checkout tmp
abbr -a gdt 'git checkout master; git branch -D tmp; git branch'  # git delete tmp

abbr -a gpm 'git push origin HEAD:master'
abbr -a gprm 'git push origin HEAD:refs/for/master'

abbr -a gp 'git pull --rebase'
abbr -a gpl 'git pull --rebase'
abbr -a gplm 'git pull --rebase origin master'

abbr -a gra 'git rebase --abort'
abbr -a grc 'git rebase --continue'
abbr -a gri 'git rebase --interactive HEAD~10'

abbr -a grh1 'git reset --hard HEAD~1'
abbr -a grh2 'git reset --hard HEAD~2'
abbr -a grh3 'git reset --hard HEAD~3'
abbr -a grh4 'git reset --hard HEAD~4'
abbr -a grh5 'git reset --hard HEAD~5'
abbr -a grh9 'git reset --hard HEAD~9'
abbr -a grhh 'git reset --hard HEAD'
abbr -a grsh 'git reset --soft HEAD~1'

abbr -a rpa 'reposet apply'
abbr -a rpd 'reposet pull'
abbr -a rpu 'reposet up'
abbr -a rps 'reposet'

switch (uname -n)
case "barn-ultra" "*celeraone*"
    # Desktop machine related abbrs

    abbr -a now 'date \'+%s\' | xclip -fi -selection clipboard'  # the current timestamp since epoch in seconds

    abbr -a prt 'cd "$PROTOFILES_DIR_PATH" ; find "$PROTOFILES_DIR_PATH" -name "*_proto.*"'

    abbr -a j 'journal \''
    abbr -a jrn 'journal \''
    abbr -a editjrn "vim -R '+normal G\$' -p $JOURNAL_FILE_PATH"
    abbr -a bkt 'bucket \''
    abbr -a tks 'tricks'
    abbr -a alh 'add-to-one-line-help \''
    abbr -a olh 'one-line-help'

    abbr -a gk 'c1-opengrok-search.py'

    abbr -a s 'subl'
    abbr -a xs 'xargs subl'
    abbr -a sh "subl (eval \$history[1])"

    switch (uname)
    # OS dependent abbrs
    case  'Darwin'
        abbr -a xc 'open -a Xcode'
        abbr -a xcode 'open -a Xcode'
        abbr -a o 'open .'
        abbr -a xo 'xargs xdg-open'
        abbr -a oh "open (eval \$history[1])"

    case  'Linux'
        abbr -a open 'xdg-open'
        abbr -a o 'xdg-open .'
        abbr -a x 'xdg-open'
        abbr -a xo 'xargs xdg-open'
        abbr -a oh "for f in (eval \$history[1]); xdg-open \"\$f\"; end"
        abbr -a ho "eval \$history[1] | xclip -fi -selection clipboard > ~/.histout"
        abbr -a xh "eval \$history[1] | xclip -fi -selection clipboard > ~/.histout"
        abbr -a go "eval \$history[1] | sed 's|\(.+*\):[0-9]*:.*|\1|' | sed '/^Binary file.*matches\$/d' | sort -u | xclip -fi -selection clipboard | tee ~/.histout"

        abbr -a pbcopy 'xclip -selection clipboard'
        abbr -a pbpaste 'xclip -selection clipboard -o'
    end
end

switch (uname -n)
case  "*celeraone*"
    # C1 related abbrs
    abbr -a qq 'cd ~/c1'
    abbr -a q 'cd-into-c1-project'
    abbr -a qa 'cd-into-c1-project authservice'
    abbr -a qap 'cd-into-c1-project authproxy'
    abbr -a qc 'cd-into-c1-project cre-api'
    abbr -a qcd 'cd-into-c1-project custom-dumont'
    abbr -a qco 'cd-into-c1-project cockpitserver'
    abbr -a qe 'cd-into-c1-project entitlement'
    abbr -a qen 'cd-into-c1-project engine'
    abbr -a qex 'cd-into-c1-project exceptions'
    abbr -a qf 'cd-into-c1-project frontend'
    abbr -a ql 'cd-into-c1-project lua'
    abbr -a qm 'cd-into-c1-project metrics'
    abbr -a qo 'cd-into-c1-project openid'
    abbr -a qp 'cd-into-c1-project pueblo'
    abbr -a qr 'cd-into-c1-project robotframework'
    abbr -a qs 'cd-into-c1-project scheduler'
    abbr -a qx 'cd-into-c1-project cre-xapi'

    abbr -a cj 'xdg-open "https://jira.celeraone.com/secure/CreateIssue!default.jspa"'  # create jira ticket
    abbr -a cre 'http --auth-type c1-auth -a'
    abbr -a og 'xdg-open "https://codereview.celeraone.com/dashboard/self"' # open gerrit
    abbr -a oj 'xdg-open "https://jira.celeraone.com/secure/Dashboard.jspa?selectPageId=11405"'  # open jira
    abbr -a rl 'xdg-open "var/log/testreports/log.html"'  # robot log
end
