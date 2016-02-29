" Compile tex with pandoc to pdf, and run
nnoremap <leader>p :!pandoc -s % -o temp_%:r.pdf && zathura temp_%:r.pdf &> /dev/null<cr><cr>
"Just compile
"nnoremap <leader>P :!pandoc -s % -o temp_%:r.pdf &> /dev/null<cr>
nnoremap <leader>P :!clear && pandoc -s % -o temp_%:r.pdf<cr>

" Lower priority of autocompletion for certain formats
set suffixes+=*.pdf,*.jpg,*.png

set colorcolumn=110
