"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

if has('nvim')
    nnoremap <leader>p <c-w><c-v>:term amm -s %<cr>i
else
    nnoremap <leader>p :!clear && amm -s %<cr>
endif

if exists('+colorcolumn')
    set colorcolumn=100
endif
