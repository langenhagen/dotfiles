" settings =========================================================================================
colorscheme slate
set guioptions -=m  "  hide menu bar
set guioptions -=T  "  hide toolbar
set guioptions -=l  " hide left scrollbar
set guioptions -=L  " hide left scrollbar when there is a vertical split window
set guioptions -=r  " hide right scrollbar
set guioptions -=R  " hide right scrollbar when there is a vertical split window

" workaround to make gvim open maximixed ===========================================================
" see: https://superuser.com/questions/140419/how-to-start-gvim-maximized
set columns=999
set lines=999

" workaround to make gvim understand system copy-paste via ctrl+v & ctrl+c =========================
nmap <C-V> "+gP
imap <C-V> <ESC><C-V>i
vmap <C-V> d<C-V>
vmap <C-C> "+y
