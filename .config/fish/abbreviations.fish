# This file contains custom fish abbreviations.
#
# author: andreasl
# version: 2018-10-18

alias fuckoff='for i in (seq 6); tput ll; openssl rand 32;  sleep 0.1; end; printf \'\\nBye :)\\n\'; shutdown 0'

if [ (uname) = 'Darwin' ]
    abbr -a xcode 'open -a Xcode'
    abbr -a xc 'open -a Xcode'
    abbr -a xo 'xargs open'
    abbr -a xs 'xargs sublime'
    abbr -a o 'open .'
    abbr -a oh "open (eval $history[1])"

    abbr -a s 'sublime'

else if [ (uname) = 'Linux' ]
    abbr -a open 'xdg-open'
    abbr -a xo 'xargs xdg-open'
    abbr -a o 'xdg-open .'
    abbr -a xs 'xargs subl'
    abbr -a oh "for f in (eval \$history[1]); xdg-open \"\$f\"; end"
    abbr -a vh "vim -p (eval \$history[1])"
    abbr -a xh "eval \$history[1] | xclip -i -f -selection primary | xclip -i -selection clipboard"

    abbr -a pbcopy 'xclip -selection clipboard'
    abbr -a pbpaste 'xclip -selection clipboard -o'

    if command -v subl >/dev/null
        abbr -a s 'subl'
    else
        abbr -a s 'vim -p'
    end
end

abbr -a xv 'xargs -o vim -p'  # xargs -o: Reopen stdin as /dev/tty in the child process before executing the command
abbr -a xx 'xargs -o vim -p'  # xargs -o: Reopen stdin as /dev/tty in the child process before executing the command
abbr -a !! 'eval $history[1]'

abbr -a fconf 'cd ~/.config/fish/ ; ls'
abbr -a sourcefish '. ~/.config/fish/config.fish'
abbr -a editabbr 'vim -p ~/.config/fish/abbreviations.fish; source ~/.config/fish/abbreviations.fish'
abbr -a vd 'vimdiff'
abbr -a fn 'functions'
abbr -a fns 'functions'

abbr -a tmls 'tmux ls'
abbr -a tmk 'tmux kill-session -t'
abbr -a tmw 'tmux kill-window -t'

abbr -a find 'find -L . -iname'
abbr -a fnd 'find -L . -iname'
abbr -a f 'find -L . -iname'
abbr -a fr 'find -L -E . -iregex'
abbr -a fnd1 'find -L . -maxdepth 1 -iname'
abbr -a tree 'tree -C -a'
abbr -a tre 'tree -C -a'
abbr -a t3 'tree -C -a -L 3'
abbr -a t3d 'tree -C -a -L 3 -d'
abbr -a v 'vim -p'
abbr -a t 'tig'
abbr -a ts 'tig show'
abbr -a r 'ranger'
abbr -a e 'vim -R "+normal :Explore\$" .'
abbr -a p 'printf (command -v python)'  version: '; and python --version; and python'
abbr -a gitup 'pwd ; cd (git rev-parse --show-toplevel)'
abbr -a gitp  'pwd ; cd (git rev-parse --show-toplevel)'
abbr -a ccat 'pygmentize -O style=native -f console256 -g'
abbr -a cct 'pygmentize -O style=native -f console256 -g'
abbr -a bp 'bpython'
abbr -a 'trenn' 'for i in (seq (tput cols)); printf \'=\'; end; printf \'\n\''

abbr -a vimh "vim -p (eval $history[1])"

abbr -a jrn 'journal \''
abbr -a j 'journal \''
abbr -a mnm 'minimerk \''
abbr -a bkt 'bucket \''
abbr -a b 'bucket \''
abbr -a tks 'tricks'
abbr -a editjrn "vim -R '+normal G\$' -p $JOURNAL_FILE_PATH"
abbr -a olh 'one-line-help'
abbr -a alh 'add-to-one-line-help \''

abbr -a cd.. 'cd ..'
abbr -a c. 'cd ..'
abbr -a cd. 'cd ..'

# grep -Hirns - like abbreviations
abbr -a h 'grep-hirns'
abbr -a g 'grep'
abbr -a hI 'grep-HirnsI'
abbr -a ch 'grep-hirns-for-cstyle-files'
abbr -a fh 'grep-hirns-for-franca-files'
abbr -a ca 'grep -Hirns --exclude-dir=.git --include \*.h --include \*.hpp --include \*.cpp --include \*.m --include \*.mm --include \*.pch --include \*.java --include \*.swift --include \*.cc --include \*.kt --color'
abbr -a cmh 'grep-hirns-for-cmake-files'
abbr -a jh 'grep-hirns-for-java-kotlin-files'
abbr -a ph 'grep-hirns-for-python-files'
abbr -a lh 'grep-hirns-for-lua-files'
abbr -a rh 'grep -HiRns --exclude-dir=\'.git\' --include="*.robot"'

abbr -a gs 'git status --short --branch --untracked-files'
abbr -a gl 'git log --stat'
abbr -a gbl 'git blame -n'
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
abbr -a gm 'git checkout master'

abbr -a gcb 'git checkout -b'
abbr -a gbn 'git checkout -b'
abbr -a gnb 'git checkout -b'

abbr -a gbd 'git branch -D'

abbr -a gps 'git push origin HEAD:refs/for/staging'
abbr -a gpm 'git push origin HEAD:master'
abbr -a gprm 'git push origin HEAD:refs/for/master'

abbr -a gpl 'git pull --rebase origin'
abbr -a gpls 'git pull --rebase origin staging'
abbr -a gplm 'git pull --rebase origin master'

abbr -a gri 'git rebase --interactive HEAD~10'
abbr -a grc 'git rebase --continue'
abbr -a gra 'git rebase --abort'

abbr -a gpa 'find $HOME/c1 -type d -iname "*.git" -execdir bash -c \'printf "\033[1m${PWD}\033[0m\n"; git pull --rebase;\' \;'
abbr -a sco 'cd ~/c1; find . -type d -iname "*.git" -execdir bash -c \'printf "\033[1m${PWD}\033[0m\n"; git pull --rebase;\' \;'

abbr -a grsh 'git reset --soft HEAD~1'
abbr -a grhh 'git reset --hard HEAD'
abbr -a grhh1 'git reset --hard HEAD~1'
abbr -a grhh9 'git reset --hard HEAD~9'
abbr -a grh9 'git reset --hard HEAD~9'

abbr -a ccr 'conda create --name tmp python=3.7 pip'
abbr -a cr 'conda remove -y --all --name'

abbr -a w 'workon'
abbr -a workoff 'conda deactivate'

abbr -a gitgrep 'git log -p --color-words -S'

abbr -a rd 'repo diff'
abbr -a rps 'repo sync -c -j8'
abbr -a rpc 'repo status ; repo diff ; repo forall -c "printf \"\033[1;36m`git rev-parse --show-toplevel`\033[0m\t`git log -n1 --pretty=format:\"%an\t%s\"`\" | grep \"Langenhagen\""'

abbr -a gr 'git review -d'
abbr -a sfr "git review master --reviewers (git log -n40 --pretty=format:'%ae' | sort | uniq -c | sort -nr | awk '{print \$2}' | head -8)"

abbr -a foldmsg 'grep -v "^#" (git rev-parse --show-toplevel)/.git/COMMIT_EDITMSG | fold -s -w 72   | sed \'s/[ \t]*$//\' > (git rev-parse --show-toplevel)/.git/COMMIT_EDITMSG;'
abbr -a rmlines 'sed -i \'/ \/rm/d\' (git diff --name-only HEAD)  # remove lines that contain the string \'/rm\''

abbr -a proto 'cd "$PROTOFILES_DIR_PATH" ; find "$PROTOFILES_DIR_PATH" -name "*_proto.*"'
abbr -a prt 'cd "$PROTOFILES_DIR_PATH" ; find "$PROTOFILES_DIR_PATH" -name "*_proto.*"'
abbr -a play 'cd "$PLAYGROUND_DIR_PATH" ; find "$PLAYGROUND_DIR_PATH" -maxdepth 1 -type d -not -path "*/\.*" -name "*"'
abbr -a ply 'cd "$PLAYGROUND_DIR_PATH" ; find "$PLAYGROUND_DIR_PATH" -maxdepth 1 -type d -not -path "*/\.*" -name "*"'
