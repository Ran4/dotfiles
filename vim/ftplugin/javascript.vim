if has('nvim')
    "Use :term instead of :!, since that supports input()
    nnoremap <leader>p <c-w><c-v>:term node %<cr>
else
    nnoremap <leader>p :!clear && node %<cr>
endif

inoremap <localleader>l console.log();<left><left>

inoremap <localleader>d <esc>"qdiwaconsole.log("<c-r>q:", <c-r>q);
nnoremap <localleader>d "qdiwaconsole.log("<c-r>q:", <c-r>q);<esc>

inoremap <localleader>r <esc>"qdiwavar <c-r>q = require("<c-r>q");
nnoremap <localleader>r "qdiwavar <c-r>q = require("<c-r>q");<esc>

" colo luna
" colo iceberg

if exists('+colorcolumn')
    set colorcolumn=100
endif

"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

iabbrev cll console.log
