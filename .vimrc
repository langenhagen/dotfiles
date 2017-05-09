" key to toggle opt ============================================================================
"function MapToggle(key, opt)
"  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
"  exec 'nnoremap '.a:key.' '.cmd
"  exec 'inoremap '.a:key." \<C-O>".cmd
"endfunction
"command -nargs=+ MapToggle call MapToggle(<f-args>)

" commands =========================================================================================

filetype plugin indent on
set tabstop=4
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" " On pressing tab, insert 4 spaces
set expandtab

syntax on
set number
set ruler
set cursorline
" set list    " shows tabs and newline characters
set ignorecase

" highlight overlength strings and trailing spaces in a red bg color
highlight Overlength ctermbg=darkred ctermfg=white guibg=#101010
let g:is_highlight_overlength = 2
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
autocmd BufWinEnter * match Overlength /\%101v.\+\|\s\+$/           " initial setting    autocmd BufWinEnter * calls the command when a window is being entered

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
map <F7> gT      " toggle tab to the left
map <F8> gt      " toggle tab to the right
map <F10> :q!<CR>
map <F11> :set number!<CR>
map <expr> <F12> ToggleHighlightOverlength()         " <expr> necessary on functions
map <expr> <S-F12> HighlightMultipleSpaces()

