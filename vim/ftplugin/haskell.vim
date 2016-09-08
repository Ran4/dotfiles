"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

"Just a regular file.hs:
"nnoremap <leader>p <c-w><c-v>:term stack --verbosity silent runghc %<cr>
nnoremap <leader>p <c-w><c-v>:term stack %<cr>

"Using stack:
nnoremap <leader>P :tabe \| term<cr>stack build && stack exec $(basename "$PWD")-exe && exit<cr>



if exists('+colorcolumn')
    set colorcolumn=80
endif

if has("gui_running")
    colo luna-gvim
else
    colo luna
endif
