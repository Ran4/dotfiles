nnoremap <leader>p :!clear && lein run<cr>
nnoremap <leader>P :lein run<cr>
nnoremap <leader>r :!clear && lein repl<cr>

imap å (
imap ¨ )
imap Å (
imap ^ )
let g:clever_f_chars_match_any_signs=";"
"modification of clever_f is done in line 335 in file
"/home/ran/dotfiles/vim/bundle/clever-f.vim/autoload/clever_f.vim

nmap å F;
nmap ¨ f;
