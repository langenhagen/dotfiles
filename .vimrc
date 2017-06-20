" Vundle stuff  ====================================================================================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



" commands =========================================================================================

filetype plugin indent on
set tabstop=4            " show existing tab with 4 spaces width
set shiftwidth=4         " when indenting with '>', use 4 spaces width
set expandtab            " On pressing tab, insert spaces
set history=200          " set ex command history to 200

syntax on
au BufNewFile,BufRead *.mm set filetype=cpp
au BufNewFile,BufRead *.m set filetype=cpp
set number
set ruler
set hlsearch
set cursorline
" set list    " shows tabs and newline characters
set ignorecase

" highlight overlength strings and trailing spaces in a red bg color
highlight Overlength ctermbg=darkred ctermfg=white guibg=#101010
let g:is_highlight_overlength = 0
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
" autocmd BufWinEnter * match Overlength /\%101v.\+\|\s\+$/           " initial setting    autocmd BufWinEnter * calls the command when a window is being entered

" delete trailing spaces and tabs
command Deltrail %s/\s\+$//e              " command for ex-mode. Must begin with uppercase letter if user-defined




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



" key bindings =====================================================================================

map <F2> :set hlsearch!<CR>
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>   " from: http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
map <F5> :edit<CR>  " refresh file
map <F7> gT       " toggle tab to the left
map <F8> gt         " toggle tab to the right
map <S-F8> gT       " toggle tab to the left
map <F10> :q!<CR>
map <F11> :set number!<CR>
map <expr> <F12> ToggleHighlightOverlength()         " <expr> necessary on functions
map <expr> <S-F12> HighlightMultipleSpaces()

