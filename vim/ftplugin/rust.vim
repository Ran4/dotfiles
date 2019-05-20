"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

if has('nvim')
    "nnoremap <leader>p <c-w><c-v>:term rustc % && ./%:r<cr>
    nnoremap <leader>p <c-w><c-v>:term cargo run -q<cr>i
    nnoremap <leader>P <c-w><c-s>:term cargo run -q<cr>i
else
    nnoremap <leader>p :!cargo run -q<cr>
endif

call SuperTabSetDefaultCompletionType("<c-x><c-o>")

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> gh :call LanguageClient#explainErrorAtPoint()<CR>
nnoremap <silent> ga :call LanguageClient#textDocument_codeAction()<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

inoremap <localleader>d <esc>"qdiwaprintln!("<c-r>q: {}", <c-r>q)<esc>
nnoremap <localleader>d "qdiwaprintln!("<c-r>q: {}", <c-r>q);<esc>

colorscheme luna
set cc=100
" Auto-formatting using rustfmt (rustup component add rustfmt-preview)
let g:rustfmt_autosave = 1
