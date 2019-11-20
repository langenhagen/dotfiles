" plugins =========================================================================================
let g:rainbow_active = 1 " or 0 ; essential for :RainbowToggle of rainbow.vim

" settings  =======================================================================================
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
set smartcase            " sutomatically switch search to case-sensitive when search query contains an uppercase letter
set tabstop=4            " show existing tab with 4 spaces width
set textwidth=100
autocmd bufreadpre COMMIT_EDITMSG setlocal textwidth=72  " set the textwidth to 72 when working with git commit messages
set visualbell           " disable beep sound when a motion fails
set whichwrap+=<,>,h,l,[,] " causes left, right arrow keys and h, l to wrap when used at beginning or end of lines. < > means cursor keys in normal and visual mode, [ ] means  cursor keys in insert mode
set wildmenu  " a visual menu to bubble through for completion in the command line
set wildmode=longest,full  " longest: autocomplete to longest common word on first tab; full: bubble through the wildnenu on pressing tab again and on following tabs

autocmd CursorHoldI * stopinsert  " automatically leave insert mode after 'updatetime' milliseconds of inaction
autocmd VimLeave * call system("xsel -ib", getreg('+'))  " keep the clipboard populated after closing vim
" autocmd BufWritePost .vimrc source $MYVIMRC  " automatically source my vimrc after writing it to disk -- causes errors bc of duplicate sourcing

" status line =====================================================================================
" color the status line when in Insert Mode
highlight statusline ctermfg=0 ctermbg=255

function ChangeStatusLineColor()
    if &formatoptions =~ 't'
        hi statusline ctermfg=25 ctermbg=255
    else
        hi statusline ctermfg=52 ctermbg=255
    endif
endfunction
autocmd InsertEnter * call ChangeStatusLineColor()
autocmd InsertLeave * hi statusline ctermfg=0 ctermbg=255

" file types  =====================================================================================
au BufNewFile,BufRead *.m set filetype=cpp         " syntax for *.m  files like cpp files
au BufNewFile,BufRead *.mm set filetype=cpp        " syntax for *.mm files like cpp files
au BufNewFile,BufRead *.plantuml set filetype=dot  " syntax for *.plantuml files like .dot files

" highlighting rules  =============================================================================
" autocompletion coloring
highlight Pmenu ctermbg=237 ctermfg=255
highlight PmenuSel ctermbg=45 ctermfg=0

" highlight overlength strings and trailing spaces with a red bg color
highlight Overlength ctermbg=darkred ctermfg=white guibg=#101010
let g:is_highlight_overlength = 1
function ToggleHighlightOverlength()
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
function HighlightMultipleSpaces()
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

" autocompletion ==================================================================================
" remap autocompletion to TAB unless the cursor is after a whitespace
" inspired by:
" https://news.ycombinator.com/item?id=13960147
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

function AddKeywordsForAutoCompletion()
    set iskeyword+=-  " treat minus as part of a word, esp for autocompletion
    set iskeyword+=.  " treat dot as part of a word, esp for autocompleution
endfunction

function RemoveKeywordsForAutoCompletion()
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

" functions =======================================================================================
function AutoLinebreakToggle()
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

" commands ========================================================================================
command AutoLinebreakToggle call AutoLinebreakToggle()
command Deltrail %s/\s\+$//e  " delete trailing spaces and tabs -- command for ex-mode. Must begin with uppercase letter if user-defined
" Python-style delimeter line
command Pytrenn norm o#<ESC>99a-<ESC>o
" C-style delimeter line
command Trenn norm o//<ESC>98a-<ESC>o

" key bindings =====================================================================================
imap <F9> <ESC>:w!<CR>    " force write file
imap <F10> <ESC>:q!<CR>       " force quit file
imap <S-F10> <ESC>:wq!<CR>    " force write quit file
map <S-F11> :set number!<CR>                           " toggle show line numbers
map <F2> :set hlsearch!<CR>
map <F3> n
map <S-F3> N
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>   " from: http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
map <F5> :edit<CR>  " refresh file
map <S-F5> vip:sort<CR>  " sort paragraph on which the cursor hovers
map <S-F6> gwip          " reformat current paragraph
map <F7> gT         " toggle tab to the left
map <F8> gt         " toggle tab to the right
map <S-F8> gT       " toggle tab to the left
map <F9> :w!<CR>    " force write file
map <F10> :q!<CR>       " force quit file
map <S-F10> :wq!<CR>    " force write quit file
map <expr> <F12> ToggleHighlightOverlength()         " <expr> necessary on functions
map <expr> <S-F12> HighlightMultipleSpaces()
map = :call AutoLinebreakToggle()<CR>
nmap Ô kJ
nmap Ø O<ESC>  " create new line above, set cursor there and go back to normal mode
nmap ø o<ESC>  " create new line below, set cursor there and go back to normal mode
vmap 1 "+y  " yanks the contents of the visual selection to the system clipboard
vmap <ENTER> "+y  " yanks the contents of the visual selection to the system clipboard
vmap 2 y/<C-R>"<CR>   " search for selected text (characters . and * can cause problems!)
vmap <S-F5> :sort<CR>  " sort in visual selection

" keep the cursor on its screen-line when scrolling a full page
nnoremap <PageUp> <C-U><C-U>
vnoremap <PageUp> <C-U><C-U>
inoremap <PageUp> <C-\><C-O><C-U><C-\><C-O><C-U>
nnoremap <PageDown> <C-D><C-D>
vnoremap <PageDown> <C-D><C-D>
inoremap <PageDown> <C-\><C-O><C-D><C-\><C-O><C-D>
nnoremap <S-Up> <C-U><C-U>
vnoremap <S-Up> <C-U><C-U>
inoremap <S-Up> <C-\><C-O><C-U><C-\><C-O><C-U>
nnoremap <S-Down> <C-D><C-D>
vnoremap <S-Down> <C-D><C-D>
inoremap <S-Down> <C-\><C-O><C-D><C-\><C-O><C-D>

" disable arrow keys in insert mode to force using normal mode as a habit
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>

" netrw settings ==================================================================================
let g:netrw_banner = 0   " disable netrw banner (toglle manually with I inside netrw)
let g:netrw_liststyle=1  " show file size and time stamp (toggle manually with i inside netrw)

" vimdiff settings ================================================================================
if &diff
    colorscheme apprentice " apprentice must be in ~/.vim/colors/ folder (https://github.com/romainl/Apprentice)
endif

" vim tips & tricks ===============================================================================

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

