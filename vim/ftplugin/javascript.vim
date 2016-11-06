if has('nvim')
    "Use :term instead of :!, since that supports input()
    nnoremap <leader>p <c-w><c-v>:term node %<cr>
else
    nnoremap <leader>p :!clear && node %<cr>
endif

inoremap <localleader>l console.log();<left><left>

colo cful256mod

if exists('+colorcolumn')
    set colorcolumn=80
endif

"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

colo cful256mod
