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
abbr -a fk 'find-and-kill-process.sh'
abbr -a fn 'functions'
abbr -a fns 'functions'
abbr -a history 'history --show-time=\'%h-%d - %H:%M:%S \' | less'
abbr -a he 'eval (history | fzf)'
abbr -a pk 'ps aux | fzf --preview "" | tr -s [:blank:] | cut -d" " -f2 | xargs -r kill'

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

abbr -a b 'bash'
abbr -a p 'python'
abbr -a bp 'bpython'
abbr -a cct 'vim --cmd \'set t_ti= t_te=\' +redraw +q'  # similar to cat, but via vim
abbr -a cdr  'cd (git rev-parse --show-toplevel)'  # abbreviation for cd to project root
abbr -a json 'json_pp'  # pretty-print json output
abbr -a l 'lf'
abbr -a psg 'ps aux | grep -i'
abbr -a shch 'shellcheck -x --exclude SC2059'
abbr -a vd 'vimdiff'
abbr -a wcl 'wc -l'

abbr -a f 'find -L . -iname'

abbr -a ca 'conda activate'
abbr -a cda 'conda deactivate'

abbr -a t 'tig'
abbr -a tb 'tig blame'
abbr -a ts 'tig show'

abbr -a tree 'tree -C -a'
abbr -a t3 'tree -C -a -L 3'
abbr -a t3d 'tree -C -a -L 3 -d'

abbr -a v 'vim -p'
abbr -a vg "vim -p (cat ~/.histout)"
abbr -a vh "vim -p (eval \$history[1])"
abbr -a e 'vim -R "+normal :Explore\$" .'

abbr -a xv 'xargs -o vim -p'  # xargs -o: Reopen stdin as /dev/tty in the child process before executing the command
abbr -a xx 'xargs -o vim -p'  # xargs -o: Reopen stdin as /dev/tty in the child process before executing the command

abbr -a r 'rg -LSn --hidden --no-heading --no-ignore'
abbr -a g 'grep -i'
abbr -a ch 'grep -HiRns --include={\*.h,\*.hpp,\*.c,\*.cpp,\*.cc,\*.m,\*.mm,\*.pch,\*.java,\*.swift,\*.kt}'
abbr -a cmh 'grep -HiRns --include={CMakeCache.txt,CMakeLists.txt,\*.cmake}'
abbr -a ph 'grep -HiRns --include=\*.py --exclude-dir={.venv\*,custom-eggs,site-packages}'
abbr -a cfh 'grep -HiRns --include={\*.cfg,\*.conf,\*.conf.in,\*.ini,setup.py,requirements.txt,Makefile,\*.yaml}'

abbr -a gb 'git branch'
abbr -a gbl 'git blame -n'
abbr -a gbr 'git branch -r'
abbr -a gcl 'git clean -dxf'
abbr -a gf 'git fetch'
abbr -a gl 'git log --stat'
abbr -a grl 'git reflog --date=iso'
abbr -a grv 'git remote -v'
abbr -a gs 'git status --short --branch --untracked-files'
abbr -a gsh 'git stash'
abbr -a gsp 'git stash pop'

abbr -a gco 'git checkout'
abbr -a gcm 'git checkout master'

abbr -a gbn 'git checkout -b'
abbr -a gnb 'git checkout -b'

abbr -a gbd 'git branch -D'

abbr -a gbt 'git checkout -b tmp; or git checkout tmp; git branch'  # git branch tmp
abbr -a gct 'git checkout -b tmp; or git checkout tmp; git branch'  # git checkout tmp
abbr -a gdt 'git checkout master; git branch -D tmp; git branch'  # git delete tmp

abbr -a gp 'git pull --rebase'
abbr -a gpl 'git pull --rebase'
abbr -a gplm 'git pull --rebase origin master'

abbr -a gps 'git push'
abbr -a gpsg 'git push origin HEAD:refs/for/master'
abbr -a gpsm 'git push origin HEAD:master'

abbr -a gra 'git rebase --abort'
abbr -a grc 'git rebase --continue'
abbr -a gri 'git rebase --interactive HEAD~10'

abbr -a gr1 'git reset --hard HEAD~1'
abbr -a gr2 'git reset --hard HEAD~2'
abbr -a gr3 'git reset --hard HEAD~3'
abbr -a gr4 'git reset --hard HEAD~4'
abbr -a gr5 'git reset --hard HEAD~5'
abbr -a gr9 'git reset --hard HEAD~9'
abbr -a grh 'git reset --hard HEAD'
abbr -a grs 'git reset --soft HEAD~1'

abbr -a rpa 'reposet apply'
abbr -a rps 'reposet'

switch (uname -n)
case "barn-ultra" "*momox*"
    # Desktop machine related abbrs

    abbr -a now 'date \'+%s\' | xclip -fi -selection clipboard'  # the current timestamp since epoch in seconds

    abbr -a prt 'cd "$PROTOFILES_DIR_PATH" ; find "$PROTOFILES_DIR_PATH" -name "*_proto.*"'

    abbr -a bkt 'bucket \''
    abbr -a tks 'tricks'
    abbr -a alh 'add-to-one-line-help \''
    abbr -a olh 'one-line-help'

    abbr -a c 'code'
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
        abbr -a o 'xdg-open'
        abbr -a o. 'xdg-open .'
        abbr -a ox 'xdg-open .; exit'
        abbr -a xo 'xargs xdg-open'
        abbr -a oh "for f in (eval \$history[1]); xdg-open \"\$f\"; end"
        abbr -a ho "eval \$history[1] | xclip -fi -selection clipboard > ~/.histout"
        abbr -a xh "eval \$history[1] | xclip -fi -selection clipboard > ~/.histout"
        abbr -a goo "eval \$history[1] | sed 's|\(.+*\):[0-9]*:.*|\1|' | sed '/^Binary file.*matches\$/d' | sort -u | xclip -fi -selection clipboard | tee ~/.histout"

        abbr -a pbcopy 'xclip -selection clipboard'
        abbr -a pbpaste 'xclip -selection clipboard -o'
    end
end

switch (uname -n)
case  "*momox*"
    # Work related abbrs
    abbr -a dcu 'docker-compose up'
    abbr -a dcd 'docker-compose down'
    abbr -a dps 'docker ps'

    abbr -a gcd 'git checkout develop'
end
