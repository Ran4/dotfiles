"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

if has('nvim')
    nnoremap <leader>p <c-w><c-v>:term swift run<cr>:q
    nnoremap <leader>P <c-w><c-s>:term swift run<cr>:q
else
    nnoremap <leader>P :!clear && swift run<cr>
    nnoremap <leader>p :!clear && swift run<cr>
endif


"Turn (where | = cursor)
"    some_value|
" into
"    print("some_value: \(some_value)")
"and exit insert mode
inoremap <localleader>d <esc>"qdiwaprint("<c-r>q: \(<c-r>q)")<esc>
nnoremap <localleader>d "qdiwaprint("<c-r>q: \(<c-r>q)")<esc>

"Used for the vim-printf plugin
let b:printf_pattern = 'print("%s \(%s)")'
" let b:printf_delim = ':'
