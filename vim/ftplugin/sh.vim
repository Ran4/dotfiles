"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

if has('nvim')
    "Use :term instead of :!, since that supports input()
    nnoremap <leader>p <c-w><c-v>:term ./%<cr>
else
    nnoremap <leader>p :!clear && ./%<cr>
endif
