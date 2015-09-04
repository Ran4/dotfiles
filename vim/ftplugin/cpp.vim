set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set wildignore+=*.out
set number
set formatoptions-=r

"syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_open = 1

"nnoremap <leader>p :!clear && (make \|\| echo "    **** FAIL ****" && exit 1) && echo "    //// Output ////" && ./%:r.out<cr>
nnoremap <leader>p :!clear && make && echo "    //// Output ////" && ./%:r.out<cr>




"""""""""""""""""""""
" ABBREVIATION STUFF
" Help delete character if it is 'empty space'
" stolen from Vim manual
function! Eatchar()
  let c = nr2char(getchar())
  return (c =~ '\s') ? '' : c
endfunction

" Replace abbreviation if we're not in comment or other unwanted places
" stolen from Luc Hermitte's excellent http://hermitte.free.fr/vim/
function! MapNoContext(key, seq)
  let syn = synIDattr(synID(line('.'),col('.')-1,1),'name')
  if syn =~? 'comment\|string\|character\|doxygen'
    return a:key
  else
    exe 'return "' .
    \ substitute( a:seq, '\\<\(.\{-}\)\\>', '"."\\<\1>"."', 'g' ) . '"'
  endif
endfunction

" Create abbreviation suitable for MapNoContext
function! Iab (ab, full)
  exe "iab <silent> <buffer> ".a:ab." <C-R>=MapNoContext('".
    \ a:ab."', '".escape (a:full.'<C-R>=Eatchar()<CR>', '<>\"').
    \"')<CR>"
endfunction

"call Iab('#d', '#define ')
call Iab('#i', '#include <><Left>')
call Iab('#I', '#include ""<Left>')
"call Iab('printf', 'printf ("\n");<C-O>?\<CR>')
"call Iab('if', 'if ()<CR>{<CR>}<Left><C-O>?)<CR>')
call Iab('if', 'if () {<CR>}<Left><C-O>?)<CR>')
"call Iab('for', 'for (;;)<CR>{<CR>}<C-O>?;;<CR>')
call Iab('for', 'for ()<CR>{<CR>}<C-O>?()<CR><RIGHT>')
call Iab('while', 'while ()<CR>{<CR>}<C-O>?)<CR>')
call Iab('else', 'else {<CR>x;<CR>}<C-O>?x;<CR><Del><Del>')
"call Iab('elseif', 'else if () {<CR>}<C-O>) {<CR>')
call Iab('elseif', 'else if () {<CR>}<C-O>?)<CR>')
"call Iab('ifelse', 'if ()<CR>{<CR>}<CR>else<CR>{<CR>}<C-O>?)<CR>')
call Iab('intmain', 'int main (int argc, char **argv)<CR>'.
 \ '{<CR>x;<CR>return 0;<CR>}<CR><C-O>?x;<CR><Del><Del>')
