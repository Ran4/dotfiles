set foldmethod=marker
normal zi
nnoremap <cr> zizt
"Don't remap <cr> in quickfix lists
au FileType qf nnoremap <buffer> <cr> <cr>
