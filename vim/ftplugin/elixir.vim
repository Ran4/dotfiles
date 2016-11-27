"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

if exists('+colorcolumn')
    set colorcolumn=80
endif

if has('nvim')
    "Use :term instead of :!, since that supports input()
    "nnoremap <leader>p <c-w><c-v>:term elixir %<cr>
    nnoremap <leader>p <c-w><c-v>:term rm Elixir.%:r.beam 2> /dev/null \|\| elixir %<cr>
else
    nnoremap <leader>p :!clear && rm Elixir.%:r.beam && elixir %<cr>
endif
