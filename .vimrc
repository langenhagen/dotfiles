" Map key to toggle opt ============================================================================
function MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)


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
set cursorline
" set list    " shows tabs and newline characters
set ignorecase


" highlight overlength strings in a red bg color
highlight OverLength ctermbg=darkred ctermfg=white guibg=#101010
match OverLength /\%101v.\+/


" key bindings =====================================================================================
MapToggle <F2> hlsearch
map <F3> :q!<CR>
map <F10> :q!<CR>






