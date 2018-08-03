"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

nnoremap <buffer> <leader>p :!amm -s %<cr>

if has('nvim')
    nnoremap <leader>p <c-w><c-v>:term amm %<cr>i
else
    nnoremap <leader>p :!clear && python %<cr>
endif

if exists('+colorcolumn')
    set colorcolumn=100
endif
