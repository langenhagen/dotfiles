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

au CursorHoldI * stopinsert  " automatically leave insert mode after 'updatetime' milliseconds of inaction

" file types  =====================================================================================

au BufNewFile,BufRead *.mm set filetype=cpp     " syntax for *.mm files like cpp files
au BufNewFile,BufRead *.m set filetype=cpp      " syntax for *.m  files like cpp files

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


" key bindings =====================================================================================

map - :edit! <bar> :Explore<CR> " reset file to last saved state and show parent dir
map <F2> :set hlsearch!<CR>
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>   " from: http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
map <F5> :edit<CR>  " refresh file
map <F7> gT         " toggle tab to the left
map <F8> gt         " toggle tab to the right
map <S-F8> gT       " toggle tab to the left
map <F9> :w!<CR>    " force write file
map <F10> :q!<CR>                                               " force quit file
map <F11> :set number!<CR>                           " toggle show line numbers
map <expr> <F12> ToggleHighlightOverlength()         " <expr> necessary on functions
map <expr> <S-F12> HighlightMultipleSpaces()
nmap ø o<ESC>  " create new line below, set cursor there and go back to normal mode
nmap Ø O<ESC>  " create new line above, set cursor there and go back to normal mode
nmap Ô kJ
vmap 1 "*y                                          " copy visual selection to system clipboard
"nmap <TODO:lassdirwaseinfallen> "*y                " yank to system clipboard


" commands ========================================================================================

command Trenn norm o//<ESC>98a-<ESC>o  " C-style delimeter line
command Pytrenn norm o#<ESC>99a-<ESC>o  " Python-style delimeter line
command Deltrail %s/\s\+$//e  " delete trailing spaces and tabs -- command for ex-mode. Must begin with uppercase letter if user-defined


" netrw settings ==================================================================================

let g:netrw_banner = 0   " disable netrw banner (toglle manually with I inside netrw)
let g:netrw_liststyle=1  " show file size and time stamp (toggle manually with i inside netrw)


" vimdiff settings ================================================================================
if &diff
    colorscheme apprentice " apprentice must be in ~/.vim/colors/ folder (https://github.com/romainl/Apprentice)

endif
