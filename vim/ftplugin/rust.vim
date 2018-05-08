"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

if has('nvim')
    "nnoremap <leader>p <c-w><c-v>:term rustc % && ./%:r<cr>
    nnoremap <leader>p <c-w><c-v>:term cargo run -q<cr>i
    nnoremap <leader>P <c-w><c-s>:term cargo run -q<cr>i
else
    nnoremap <leader>p :!cargo run -q<cr>
endif

set rtp+=~/.vim/bundle/deoplete.nvim
call deoplete#enable()

inoremap <localleader>d <esc>"qdiwaprintln!("<c-r>q: {}", <c-r>q)<esc>
nnoremap <localleader>d "qdiwaprintln!("<c-r>q: {}", <c-r>q);<esc>
nnoremap <buffer> <localleader>g <Plug>DeopleteRustGoToDefinitionSplit
