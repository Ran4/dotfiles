"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

" Compile tex with pandoc to pdf, and run
nnoremap <leader>p :!pdflatex % && zathura %:r.pdf &> /dev/null &<CR>

"Just compile
nnoremap <leader>P :!pdflatex %<CR>

"old, using pandoc
"nnoremap <leader>p :!pandoc -s % -o temp_%:r.pdf && zathura temp_%:r.pdf &> /dev/null<cr><cr>
"nnoremap <leader>P :!pandoc -s % -o temp_%:r.pdf &> /dev/null<cr>
"nnoremap <leader>P :!clear && pandoc -s % -o temp_%:r.pdf<cr>

" Lower priority of autocompletion for certain formats
set suffixes+=*.pdf,*.jpg,*.png
set colorcolumn=110
"Visually wrap long lines per word, don't wrap in the middle of a word.
set linebreak

"Enable word completion with spell-checking
"set complete+=kspell

"Mappings
nnoremap <localleader>rr :source ~/.vim/ftplugin/tex.vim<cr>

inoremap <localleader>b <esc>bcw\begin{<c-r>"}<cr>\end{<c-r>"}<c-o>O
inoremap <localleader>f \frac{}{}<left><left><left>
inoremap <localleader>s \section{}<left>
inoremap <localleader>i \textit{}<left>
inoremap í \textit{}<left>
