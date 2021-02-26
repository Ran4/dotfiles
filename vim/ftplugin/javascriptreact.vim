" nnoremap <space> :w!<cr>

" Needed to make parcel HMR not break ("disable safe write")
set backupcopy=yes
" command! -nargs=0 Prettier :CocCommand prettier.formatFile
" nnoremap <silent> <leader>f :CocCommand prettier.formatFile<CR>
" nnoremap <silent> <leader>f :Prettier<cr>

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
nnoremap <silent> <leader>f :call CocAction('format')<cr>

nmap <silent> gd <Plug>(coc-definition)

