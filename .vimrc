" plugins =========================================================================================

let g:rainbow_active = 1 " or 0 ; essential for :RainbowToggle of rainbow.vim

" settings  =======================================================================================

syntax on  " syntax highlighting. turn off if vim is too slow with :syntax off
filetype plugin indent on

set visualbell           " disable beep sound when a motion fails
set tabstop=4            " show existing tab with 4 spaces width
set shiftwidth=4         " when indenting with '>', use 4 spaces width
set expandtab            " On pressing tab, insert spaces
set history=100          " set ex command history to given number
"set autochdir           " set the pwd to the current file automatically, might conflict with ctags
set number  " show line numbers
set ruler   " shows line and column numbers in the status bar
set hlsearch  " highlight search
set incsearch            " highlight the next match while typing
set nocursorline  " underline current line, slows vim down, use `set nocursorline` then
set ignorecase  " search ignores case
set laststatus=2   " shows the current filename in the status bar
set mouse=a             " enable mouse support
" set list    " shows tabs and newline characters
set whichwrap+=<,>,h,l,[,] " causes left and right arrow keys and h and l to wrap when used at beginning or end of lines. < > are the cursor keys used in normal and visual mode, [ ] are the cursor keys in insert mode
set textwidth=100
autocmd bufreadpre COMMIT_EDITMSG setlocal textwidth=72  " set the textwidth to 72 when working with git commit messages
set linebreak " break long lines between words, not in the middle of a word
let &showbreak="\u2026 "  " shows this symbol at the beginning of a broken line
set formatprg=par " use the given program to process selected text and put the output back when pressing gq<SELECTION>, e.g. gqip. It the programm is not available, gwip still does work with vim's internal formatter
set formatoptions-=t " make text not wrap at textwidth initially
set formatoptions-=a " make text not autoformat initially

set iskeyword+=-  " treat minus as part of a word, esp for autocompletion
set iskeyword+=.  " treat dot as part of a word, esp for autocompleution

autocmd VimLeave * call system("xsel -ib", getreg('+'))  " keep the clipboard populated after closing vim
autocmd CursorHoldI * stopinsert  " automatically leave insert mode after 'updatetime' milliseconds of inaction
" autocmd BufWritePost .vimrc source $MYVIMRC  " automatically source my vimrc after writing it to disk -- causes errors bc of duplicate sourcing

" color the status line when in Insert Mode
highlight statusline ctermfg=0 ctermbg=255
autocmd InsertEnter * hi statusline ctermfg=52 ctermbg=255
autocmd InsertLeave * hi statusline ctermfg=0 ctermbg=255

" file types  =====================================================================================

au BufNewFile,BufRead *.mm set filetype=cpp        " syntax for *.mm files like cpp files
au BufNewFile,BufRead *.m set filetype=cpp         " syntax for *.m  files like cpp files
au BufNewFile,BufRead *.plantuml set filetype=dot  " syntax for *.plantuml files like .dot files

" highlighting rules  =============================================================================

" HIGHLIGHT OVERLENGTH STRINGS AND TRAILING SPACES IN A RED BG COLOR
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

" HIGHLIGHT MULTIPLE SPACES AND TABS
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
" found here:
" https://news.ycombinator.com/item?id=13960147
" TODO: would also be nice with shift + TAB
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" open autocompletion as you type
" this simple solution might bring some caveats and may crash things
"function! OpenCompletion()
"    if !pumvisible() && ((v:char >= 'a' && v:char <= 'z') || (v:char >= 'A' && v:char <= 'Z'))
"        "call feedkeys("\<C-x>\<C-o>", "n")
"        call feedkeys("\<C-p>\<C-n>", "t")
"    endif
"endfunction
"autocmd InsertCharPre * call OpenCompletion()

" functions =======================================================================================

function AutoformatToggle()

if &formatoptions =~ 'a'
    set formatoptions-=t
    set formatoptions-=a
    set formatoptions?
    echo "Autoformat deactivated"
else
    set formatoptions+=t
    set formatoptions+=a
    set formatoptions?
    echo "Autoformat activated"
endif

endfunction

" commands ========================================================================================

" C-style delimeter line
command Trenn norm o//<ESC>98a-<ESC>o
" Python-style delimeter line
command Pytrenn norm o#<ESC>99a-<ESC>o
command Deltrail %s/\s\+$//e  " delete trailing spaces and tabs -- command for ex-mode. Must begin with uppercase letter if user-defined
command AutoformatToggle if &formatoptions =~ 'a' | set formatoptions-=t | set formatoptions-=a | set formatoptions? | echo "Autoformat deactivated" | else | set formatoptions+=t | set formatoptions+=a | echo "Autoformat activated" | set formatoptions? | endif

" key bindings =====================================================================================

imap <F9> <ESC>:w!<CR>    " force write file
imap <F10> <ESC>:q!<CR>       " force quit file
imap <S-F10> <ESC>:wq!<CR>    " force write quit file
map <C-s> vip:sort<CR>  " sort paragraph on which the cursor hovers
map <S-F11> :set number!<CR>                           " toggle show line numbers
map <F2> :set hlsearch!<CR>
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>   " from: http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
map <F5> :edit<CR>  " refresh file
map <S-F5> vip:sort<CR>  " sort paragraph on which the cursor hovers
map <F7> gT         " toggle tab to the left
map <F8> gt         " toggle tab to the right
map <S-F8> gT       " toggle tab to the left
map <F9> :w!<CR>    " force write file
map <F10> :q!<CR>       " force quit file
map <S-F10> :wq!<CR>    " force write quit file
map <expr> <F12> ToggleHighlightOverlength()         " <expr> necessary on functions
map <expr> <S-F12> HighlightMultipleSpaces()
map <expr> = AutoformatToggle()
nmap Ô kJ
nmap Ø O<ESC>  " create new line above, set cursor there and go back to normal mode
nmap ø o<ESC>  " create new line below, set cursor there and go back to normal mode
vmap 1 "+y  " yanks the contents of the visual selection to the system clipboard
vmap <ENTER> "+y  " yanks the contents of the visual selection to the system clipboard
vmap 2 y/<C-R>"<CR>   " search for selected text (characters . and * can cause problems!)
vmap <C-s> :sort<CR>  " sort in visual selection
vmap <S-F5> :sort<CR>  " sort in visual selection

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
