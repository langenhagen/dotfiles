" Map key to toggle opt ============================================================================
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

" highlight overlength strings in a red bg color
highlight Overlength ctermbg=darkred ctermfg=white guibg=#101010

let g:is_highlight_overlength = 1
function! ToggleHighlightOverlength()
    if g:is_highlight_overlength == 0
        let g:is_highlight_overlength = 1
        match Overlength /\%101v.\+/
        echo "Highlight Overlength ON"
    else
        let g:is_highlight_overlength = 0
        match Overlength /\%9999v.\+/
        echo "Highlight Overlength OFF"
    endif
endfunction
match Overlength /\%101v.\+/           " initial setting
map <expr> <F3> ToggleHighlightOverlength()


" key bindings =====================================================================================
map <F2> :set hlsearch!<CR>
map <F10> :q!<CR>

map <F7> gT      " toggle tab to the left
map <F8> gt      " toggle tab to the right
map <F5> :edit<CR>  " refresh file



