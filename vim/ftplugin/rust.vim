"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

if has('nvim')
    "nnoremap <leader>p <c-w><c-v>:term rustc % && ./%:r<cr>
    nnoremap <leader>p <c-w><c-v>:term cargo run<cr>
else
    nnoremap <leader>p :!rustc % && ./%:r<cr>
endif

set rtp+=~/.vim/bundle/deoplete.nvim
call deoplete#enable()
