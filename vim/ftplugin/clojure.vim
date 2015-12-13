"~/.vim/colors/cful256mod.vim
imap å [
imap ¨ ]

"Quickly navigate between parens
nnoremap W /(<cr>
nnoremap B ?(<cr>
nnoremap E /)<cr>
nnoremap ge ?)<cr>

if exists('+colorcolumn')
    set colorcolumn=110
endif

colo cful256mod
nnoremap <leader>p :!clear && lein run<cr>
nnoremap <leader>P :lein run<cr>
nnoremap <leader>r :!clear && lein repl<cr>

let g:clever_f_chars_match_any_signs=";"
"modification of clever_f is done in line 335 in file
"/home/ran/dotfiles/vim/bundle/clever-f.vim/autoload/clever_f.vim
