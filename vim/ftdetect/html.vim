" removes current htmldjango detection located at $VIMRUNTIME/filetype.vim
autocmd! BufNewFile,BufRead *.html
autocmd  BufNewFile,BufRead *.html   call MaybeDjangoHtml()

" Checks if the first few lines match regex
func! MaybeDjangoHtml()
    let n = 1
    while n < 20 && n < line("$")
    if getline(n) =~ '\<DTD\s\+XHTML\s'
        setf xhtml
        return
    endif
    if getline(n) =~ '{%\|{{\|{#'
        setf htmldjango
        return
    endif
    let n = n + 1
    endwhile
    setf html
endfunc
