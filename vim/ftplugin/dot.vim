"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

nnoremap <leader>p :!mkdir -p output && dot -Tpng % > output/%:r.png && open output/%:r.png<CR><CR>

nnoremap <buffer> <space> :update<cr>:!dot -Tpng % > output/%:r.png &> /dev/null &<CR><CR>
"nnoremap <buffer> <space> :update<cr>:!dot -Tsvg % > output/%:r.svg &> /dev/null &<CR><CR>
nnoremap <localleader>c :update<cr>:!dot -Tsvg % > %:r.svg &> /dev/null &<CR><CR>
nnoremap <localleader>o :!open %:r.svg &> /dev/null &<CR><CR>
setlocal commentstring=//\ %s
