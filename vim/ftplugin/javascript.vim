nnoremap <leader>p :!clear && node %<cr>

inoremap <localleader>l console.log();<left><left>

colo cful256mod

if exists('+colorcolumn')
    set colorcolumn=80
endif

"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

colo cful256mod
