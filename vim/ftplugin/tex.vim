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

nnoremap ´´ :source ~/.vim/ftplugin/tex.vim<cr>

inoremap ´b <esc>bcw\begin{<c-r>"}<cr>\end{<c-r>"}<c-o>O
inoremap ´f \frac{}{}<left><left><left>
inoremap ´s \section{}<left>
