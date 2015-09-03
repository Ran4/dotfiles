set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

set wildignore+=*.out

set number

"nnoremap <leader>p :!clear && (make \|\| echo "    **** FAIL ****" && exit 1) && echo "    //// Output ////" && ./%:r.out<cr>
nnoremap <leader>p :!clear && make && echo "    //// Output ////" && ./%:r.out<cr>
