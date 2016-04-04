" Remove timestamps
"e.g.
"[00:53.97][01:42.94]Put on a brand-new shirt
"to
"Put on a brand-new shirt
" nnoremap <leader>m :w ~/tmp/lyrics_lrc_stripped/%:r.txt
" nnoremap <leader>o :e ~/tmp/lyrics_lrc_stripped/%:r.txt
" nnoremap <leader>p :%s/\[.\+\]//g<cr>

"nnoremap <leader>p :w ~/tmp/lyrics_lrc_stripped/%:r.txt<cr>:e ~/tmp/lyrics_lrc_stripped/%:r.txt<cr>:%s/\[.\+\]//g<cr>

function! MoveAndStripLrc()
    w! ~/tmp/lyrics_lrc_stripped/%:r.txt
    e ~/tmp/lyrics_lrc_stripped/%:r.txt
    1,$s/\[.\+\]//g
    norm <cr>
    "update
endfunction

nnoremap <leader>p :call MoveAndStripLrc()<cr>
