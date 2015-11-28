" Compile tex with pandoc to pdf, and run
nnoremap <leader>p :!pandoc -s % -o %:r.pdf && zathura %:r.pdf &> /dev/null<cr><cr>
"Just compile
nnoremap <leader>P :!pandoc -s % -o %:r.pdf &> /dev/null<cr>

" Lower priority of autocompletion for certain formats
set suffixes+=*.pdf,*.jpg,*.png
