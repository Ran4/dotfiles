"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

nnoremap <leader>p :!mkdir -p output && dot -Tpng % > output/%:r.png && open output/%:r.png<CR><CR>

nnoremap <space> :update<cr>:!dot -Tpng % > output/%:r.png &> /dev/null &<CR><CR>
