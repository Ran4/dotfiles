"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

set foldmethod=marker
set foldmarker={,}
set foldlevel=999

" Coc: Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
nnoremap <silent> <leader>f :CocCommand prettier.formatFile<CR>
