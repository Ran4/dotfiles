set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set wildignore+=*.out
set number
set formatoptions-=r

set colorcolumn=110

"syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" fix 2.0 -> 2.0F on this line
"nnoremap <leader>f :s,\(\d\+\.\d\)\([^fF]\),\1F\2,g
nnoremap <leader>f :s,\v(\d+\.\d)([^fF]),\1F\2,g
