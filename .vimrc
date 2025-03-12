" plugins ==========================================================================================
let g:rainbow_active = 1 " or 0 ; essential for :RainbowToggle of rainbow.vim

call plug#begin('~/.vim/plugged')
Plug 'vim-python/python-syntax'  " Improved Python syntax highlighting
let g:python_highlight_all = 1
call plug#end()


" settings  ========================================================================================
filetype plugin indent on
syntax on  " syntax highlighting. turn off if vim is too slow with :syntax off

let &showbreak="\u2026 "  " shows this symbol at the beginning of a broken line

"set autochdir           " set the pwd to the current file automatically, might conflict with ctags
set expandtab            " On pressing tab, insert spaces
set formatoptions+=j  " delete comment characters when joining lines
set formatoptions-=a  " make text not autoformat initially
set formatoptions-=c  " disable auto-wrap comments using textwidth, inserting the current comment leader automatically
set formatoptions-=o  " disable auto insert the current comment leader after hitting 'o' or 'O' in Normal mode
set formatoptions-=r  " disable auto insert the current comment leader after hitting <Enter> in Insert mode
set formatoptions-=t  " make text not wrap at textwidth initially
set formatprg=par " use the given program to process selected text and put the output back when pressing gq<SELECTION>, e.g. gqip. If the program is not available, gwip still does work with vim's internal formatter
set history=1000         " set ex command history to given number; might also affect undo operations
set hlsearch  " highlight search
set ignorecase  " search ignores case
set incsearch            " highlight the next match while typing
set laststatus=2   " shows the current filename in the status bar
set linebreak " avoid wrapping a line in the middle of a word
" set list    " shows tabs and newline characters
set mouse=a             " enable mouse support
set nocursorline  " underline current line, slows vim down, use `set nocursorline` then
set noerrorbells         " Disable beep on errors
set number               " show line numbers
set ruler                " shows line and column numbers in the status bar
set shiftwidth=4         " when indenting with '>', use 4 spaces width
set smartcase            " sutomatically switch search to case-sensitive when search query contains an uppercase letter; needs also ignorecase
set tabpagemax=99     " maximum number of tabs that can be opened from the command line
set tabstop=4            " show existing tab with 4 spaces width
set textwidth=100
autocmd bufreadpre COMMIT_EDITMSG setlocal textwidth=72  " set the textwidth to 72 when working with git commit messages
set visualbell           " disable beep sound when a motion fails
set whichwrap+=<,>,h,l,[,] " causes left, right arrow keys and h, l to wrap when used at beginning or end of lines. < > means cursor keys in normal and visual mode, [ ] means  cursor keys in insert mode
set wildmenu  " a visual menu to bubble through for completion in the command line
set wildmode=longest,full  " longest: autocomplete to longest common word on first tab; full: bubble through the wildnenu on pressing tab again and on following tabs

autocmd CursorHoldI * stopinsert  " automatically leave insert mode after 'updatetime' milliseconds of inaction
autocmd VimLeave * call system("xsel -ib", getreg('+'))  " keep the clipboard populated after closing vim
autocmd BufWritePost .vimrc source $MYVIMRC  " automatically source my vimrc after writing it to disk

" colorscheme ======================================================================================
if &diff
    colorscheme apprentice " apprentice must be in ~/.vim/colors/ folder (https://github.com/romainl/Apprentice)
else
    colorscheme ron
endif

" status line ======================================================================================
" color the status line when in Insert Mode
highlight statusline ctermfg=0 ctermbg=255

function! ChangeStatusLineColor()
    if &formatoptions =~ 't'
        hi statusline ctermfg=25 ctermbg=255
    else
        hi statusline ctermfg=52 ctermbg=255
    endif
endfunction
autocmd InsertEnter * call ChangeStatusLineColor()
autocmd InsertLeave * hi statusline ctermfg=0 ctermbg=255

" file types  ======================================================================================
au BufNewFile,BufRead *.m set filetype=cpp         " syntax for *.m  files like cpp files
au BufNewFile,BufRead *.mm set filetype=cpp        " syntax for *.mm files like cpp files
au BufNewFile,BufRead *.plantuml set filetype=dot  " syntax for *.plantuml files like .dot files

" highlighting rules  ==============================================================================
" autocompletion coloring
highlight Pmenu ctermbg=237 ctermfg=255
highlight PmenuSel ctermbg=45 ctermfg=0

" highlight overlength strings and trailing spaces with a red bg color
highlight Overlength ctermbg=darkred ctermfg=white guibg=#101010
let g:is_highlight_overlength = 1
function! ToggleHighlightOverlength()
    if g:is_highlight_overlength == 0
        let g:is_highlight_overlength = 2
        match Overlength /\%101v.\+\|\s\+$/                 " find overlength or aka ( Backslash Pipe )  trailing spaces
        echo "Highlight Overlength ON and Trailing Spaces ON"
    elseif g:is_highlight_overlength == 2
        let g:is_highlight_overlength = 1
        match Overlength /\s\+$/                 " find just trailing spaces
        echo "Highlight Overlength OFF and Trailing Spaces ON"
    elseif g:is_highlight_overlength == 1
        let g:is_highlight_overlength = 0
        match
        echo "Highlight Overlength OFF and Trailing Spaces OFF"
    endif
endfunction
autocmd BufWinEnter * match Overlength /\s\+$/ " initial setting  autocmd BufWinEnter * calls  the command when a window is being entered

" highlight multiple spaces and tabs
highlight MultipleSpaces ctermbg=darkred guibg=darkred
let g:is_highlight_multiple_spaces = 0
function! ToggleHighlightMultipleSpaces()
    if g:is_highlight_multiple_spaces == 0
        let g:is_highlight_multiple_spaces = 1
        match MultipleSpaces /\s\{2,}/
        echo "Highlight Multiple Spaces ON"
    elseif g:is_highlight_multiple_spaces == 1
        let g:is_highlight_multiple_spaces = 0
        match
        echo "Highlight Multiple Spaces OFF"
    endif
endfunction

" autocompletion ===================================================================================
" remap autocompletion to TAB unless the cursor is after a whitespace
" inspired by: https://news.ycombinator.com/item?id=13960147
function! InsertTabWrapper(is_shift)
    let col = col('.') - 1
    if a:is_shift
        if !col || getline('.')[col - 1] !~ '\k'
            return "\<tab>"
        else
            return "\<c-p>"
        endif
    else
        if !col || getline('.')[col - 1] !~ '\k'
            return "\<S-tab>"
        else
            return "\<c-n>"
        endif
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper(0)<cr>
inoremap <S-tab> <c-r>=InsertTabWrapper(1)<cr>

function! AddKeywordsForAutoCompletion()
    set iskeyword+=-  " treat minus `-` as part of a word, esp for autocompletion
    set iskeyword+=.  " treat dot `.` as part of a word, esp for autocompletion
endfunction

function! RemoveKeywordsForAutoCompletion()
    set iskeyword-=-
    set iskeyword-=.
endfunction

autocmd InsertEnter * call AddKeywordsForAutoCompletion()
autocmd InsertLeave * call RemoveKeywordsForAutoCompletion()

" open autocompletion as you type
" this simple solution might bring some caveats and can crash things
"function! OpenCompletion()
"    if !pumvisible() && ((v:char >= 'a' && v:char <= 'z') || (v:char >= 'A' && v:char <= 'Z'))
"        "call feedkeys("\<C-x>\<C-o>", "n")
"        call feedkeys("\<C-p>\<C-n>", "t")
"    endif
"endfunction
"autocmd InsertCharPre * call OpenCompletion()

" toggle commenting ================================================================================
let b:comment_prefix = "#"
au BufRead,BufNewFile *.{c,cpp,h,hpp,cs,go,java,js} let b:comment_prefix = "//"
au BufRead,BufNewFile *.lua let b:comment_prefix = "--"
au BufRead,BufNewFile *.{py,sh} let b:comment_prefix = "#"
au BufRead,BufNewFile .vimrc let b:comment_prefix = "\""
au BufRead,BufNewFile *.plantuml let b:comment_prefix = "'"

function! ToggleComment()
    " Toggle a comment.
    let l:current_line = getline(".")
    if l:current_line =~ '^\s*' . b:comment_prefix . " "
        execute "normal! ^" . strlen(b:comment_prefix) . "xx"
    elseif l:current_line =~ '^\s*' . b:comment_prefix
        execute "normal! ^" . strlen(b:comment_prefix) . "x"
    else
        execute "normal! I" . b:comment_prefix . " "
    endif
endfunction

" functions ========================================================================================
function! ToggleAutoLinebreak()
    if &formatoptions =~ 't'
        "set formatoptions-=a  " make text not autoformat initially
        set formatoptions-=c  " auto-wrap comments using textwidth, inserting the current comment leader automatically
        set formatoptions-=t  " make text not wrap at textwidth initially
        echo "Auto linebreak deactivated"
    else
        "set formatoptions+=a
        set formatoptions+=c
        set formatoptions+=t
        normal! gwgw
        echo "Auto linebreak activated"
    endif
endfunction

" commands =========================================================================================
command! Deltrail %s/\s\+$//e  " delete trailing spaces and tabs -- command for ex-mode. Must begin with uppercase letter if user-defined
" Python-style delimiter line
command! Pytrenn norm o#<ESC>99a-<ESC>o
" C-style delimiter line
command! Trenn norm o//<ESC>98a-<ESC>o
" Lua atyle delimiter line
command! Luatrenn norm o<ESC>100a-<ESC>o
" Write buffer via sudo tee to current file %
command! SudoWrite w !sudo tee %

" abbreviations ====================================================================================

abbreviate AS Autosave
abbreviate Rfctr Refactor
abbreviate rfctr refactor
abbreviate rq require
abbreviate rqd required

" key bindings =====================================================================================
map <C-_> :call ToggleComment()<CR>|  " <C-_> maps to ctrl + / in vim
imap <C-_> <ESC>:call ToggleComment()<CR>|  " <C-_> maps to ctrl + / in vim
map <C-e> :FZF!<CR>|  " open fzf in full screen
map <F2> :call ToggleAutoLinebreak()<CR>
imap <F2> <ESC>:call ToggleAutoLinebreak()<CR>a|
map <F3> n
set <S-F3>=[1;2R
map <S-F3> N
map <F15> NF15> NF15> NF15> NF15> N  " shift+F3 in neovim
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>|   " from: http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
map <F5> :edit<CR>|  " refresh file
map <S-F5> vip:sort<CR>|    " sort paragraph on which the cursor hovers
map <F17> vip:sort<CR>|     " shift-F5 in neovim
vmap <S-F5> :sort<CR>|  " sort in visual selection
vmap <F17> :sort<CR>|   " shift-F5 in neovim
map <S-F6> gwip|    " reformat current paragraph
map <F18> gwip|     " shift-F6 in neovim
map <F7> gT|        " toggle tab to the left
map <F8> gt|         " toggle tab to the right
map <S-F8> gT|    " toggle tab to the left
map <F20> gT|     " shift-F8 in neovim
map <F9> :w!<CR>|    " force write file
imap <F9> <ESC>:w!<CR>|    " force write file
map <S-F9> :wq!<CR>|    " force write quit file
map <F21> :wq!<CR>|     " shift-F9 in neovim
imap <S-F9> <ESC>:wq!<CR>|    " force write quit file
imap <F21> <ESC>:wq!<CR>|     " shift-F9 in neovim
map <F10> :q!<CR>|       " force quit file
imap <F10> <ESC>:q!<CR>|       " force quit file
map <S-F10> :wq!<CR>|    " force write quit file
map <F22> :wq!<CR>|      " shift-F10 in neovim
imap <S-F10> <ESC>:wq!<CR>|    " force write quit file
imap <F22> <ESC>:wq!<CR>|      " shift-F10 in neovim
map <S-F11> :set number!<CR>|    " toggle show line numbers
map <F23> :set number!<CR>|      " shift-F11 in neovim
imap <S-F11> <ESC>:set number!<CR>a|    " toggle show line numbers
imap <F23> <ESC>:set number!<CR>a|      " shift-F11 in neovim
map <leader><BS> :q!<CR>|   " force quit file
map <expr> <F12> ToggleHighlightOverlength()|         " <expr> or :call ... <CR> necessary on functions
imap <F12> <ESC>:call ToggleHighlightOverlength()<CR>a|
map <expr> <S-F12> ToggleHighlightMultipleSpaces()
map <expr> <F24> ToggleHighlightMultipleSpaces()    " shift-F12 in neovim
imap <S-F12> <ESC>:call ToggleHighlightMultipleSpaces()<CR>a
imap <F24> <ESC>:call ToggleHighlightMultipleSpaces()<CR>a    " shift-F12 in neovim
nmap Ô kJ
nmap Ø O<ESC>|  " create new line above, set cursor there and go back to normal mode
nmap ø o<ESC>|  " create new line below, set cursor there and go back to normal mode
vmap <ENTER> "+y|  " yank the contents of the visual selection to the system clipboard
vmap @ y/<C-R>"<CR>|   " search for selected text (characters . and * can cause problems!)

" keep the cursor on its screen-line when scrolling a full page
noremap <PageUp> <C-U><C-U>
inoremap <PageUp> <C-\><C-O><C-U><C-\><C-O><C-U>
noremap <PageDown> <C-D><C-D>
inoremap <PageDown> <C-\><C-O><C-D><C-\><C-O><C-D>
noremap <S-Up> <C-U><C-U>
inoremap <S-Up> <C-\><C-O><C-U><C-\><C-O><C-U>
noremap <S-Down> <C-D><C-D>
inoremap <S-Down> <C-\><C-O><C-D><C-\><C-O><C-D>

" netrw settings ===================================================================================
let g:netrw_banner = 0   " disable netrw banner (toglle manually with I inside netrw)
let g:netrw_liststyle=1  " show file size and time stamp (toggle manually with i inside netrw)

" vim tips & tricks ================================================================================
" set spell!  " disable/enable spellchecking
" set spell?  " read a setting

"set formatoptions+=l  " long lines are not broken in insert mode: When a line was longer than 'textwidth'
                       " when the insert command started, Vim does not automatically format it.

"set formatoptions+=n  " when formatting text, recognize numbered lists.  This actually uses
                       " the 'formatlistpat' option, thus any kind of list can be used.  The
                       " indent of the text after the number is used for the next line.  The
                       " default is to find a number, optionally followed by '.', ':', ')',
                       " ']' or '}'.  Note that 'autoindent' must be set too.  Doesn't work
                       " well together with "2".
                       " Example:
                       " 1. the first item
                       "   wraps
                       " 2. the second item
