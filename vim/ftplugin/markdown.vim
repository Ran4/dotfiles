"remaps å¨Å^ to []{} in various ways
"source ~/.vim/ftplugin/remap_to_brackets.vim
" Override the å remapping because I write markdown Swedish often enough...
inoremap å å

let uname = substitute(system('uname'), '\n', '', '')
" Example values: Linux, Darwin, MINGW64_NT-10.0, MINGW32_NT-6.1

if uname == 'Darwin'
  nnoremap <leader>p :!pandoc -s % -o /tmp/out_%:r.html --css ~/dotfiles/pandoc/pandoc.css && open /tmp/out_%:r.html &<cr><cr>
  " nnoremap <silent> <space> :update<cr>:!pandoc -s % -o /tmp/out_%:r.html &> /dev/null &<cr><cr>
  nnoremap <silent> <space> :update<cr>:!pandoc -s % -o /tmp/out_%:r.html --css ~/dotfiles/pandoc/pandoc.css &> /dev/null &<cr><cr>
else
  nnoremap <leader>p :!pandoc -s % -o /tmp/out_%:r.html --css ~/dotfiles/pandoc/pandoc.css && xdg-open /tmp/out_%:r.html &<cr><cr>
endif
nnoremap <silent> <leader>P :!pandoc -s % -o /tmp/out_%:r.html &> /dev/null &<cr><cr>
"nnoremap <silent> <space> :update<cr>:exec "!pandoc -s % -o /tmp/out_%:r.html --css ~/orexplore/git/misc-hermod/css/biggercode.css &> /dev/null &"<cr><cr>
"nnoremap <silent> <space> :update<cr>:exec "!pandoc -s % -o output/out_%:r.html --css ~/orexplore/git/misc-hermod/css/biggercode.css &> /dev/null &"<cr><cr>
"nnoremap <space> :update<cr>:make html<cr>:redrawstatus<cr>

"nnoremap <silent> <space> :update<cr>:exec "make"<cr><cr>

"nnoremap <localleader>c :colo Tomorrow-Night<cr>:colo Tomorrow-Night<cr>
nnoremap <localleader>c :colo iceberg<cr>
 
imap ä ä
cmap ä ä


set nonumber

setlocal commentstring=<!--\ %s\ -->

set colorcolumn=110 " Vim filetype plugin
set textwidth=110

" Language:		Markdown
" Maintainer:		Tim Pope <vimNOSPAM@tpope.org>
" Last Change:		2013 May 30

if exists("b:did_ftplugin")
  finish
endif

"runtime! ftplugin/html.vim ftplugin/html_*.vim ftplugin/html/*.vim

setlocal comments=fb:*,fb:-,fb:+,n:> commentstring=>\ %s
setlocal formatoptions+=tcqln formatoptions-=r formatoptions-=o
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+\\\|^\\[^\\ze[^\\]]\\+\\]:

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= "|setl cms< com< fo< flp<"
else
  let b:undo_ftplugin = "setl cms< com< fo< flp<"
endif

function! MarkdownFold()
  let line = getline(v:lnum)

  " Regular headers
  let depth = match(line, '\(^#\+\)\@<=\( .*$\)\@=')
  if depth > 0
    return ">" . depth
  endif

  " Setext style headings
  let nextline = getline(v:lnum + 1)
  if (line =~ '^.\+$') && (nextline =~ '^=\+$')
    return ">1"
  endif

  if (line =~ '^.\+$') && (nextline =~ '^-\+$')
    return ">2"
  endif

  return "="
endfunction

if has("folding") && exists("g:markdown_folding")
  setlocal foldexpr=MarkdownFold()
  setlocal foldmethod=expr
  let b:undo_ftplugin .= " foldexpr< foldmethod<"
endif

" vim:set sw=2:

set foldmethod=marker
norm zR
set linebreak
