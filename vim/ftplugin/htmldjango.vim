"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

inoremap <localleader>< <esc>bce<<c-r>"></<c-r>"><c-o>F<
inoremap <localleader>> <esc>bce<<c-r>"></<c-r>">

" Best one yet
inoremap %%  %}<esc>I{% <esc>f%i <left>

set colorcolumn=110
