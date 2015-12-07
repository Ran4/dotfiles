imap å [
imap ¨ ]

if exists('+colorcolumn')
    set colorcolumn=80
endif

set makeprg=python\ -u\ %
nnoremap <f5> :w:Make<cr>

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

iabbrev adn and
iabbrev pritn print
iabbrev true: True:
iabbrev false: False:

set wildignore+=*.pyc

nnoremap <silent> <buffer> ]] :call <SID>Python_jump('/^\(class\\|def\)')<cr>
nnoremap <silent> <buffer> [[ :call <SID>Python_jump('?^\(class\\|def\)')<cr>
nnoremap <silent> <buffer> ]m :call <SID>Python_jump('/^\s*\(class\\|def\)')<cr>
nnoremap <silent> <buffer> [m :call <SID>Python_jump('?^\s*\(class\\|def\)')<cr>

" Alternatives, also for visual mode
nnoremap <silent> <buffer> <leader>c :call <SID>Python_jump('/^\(class\\|def\)')<cr>zz
nnoremap <silent> <buffer> <leader>C :call <SID>Python_jump('?^\(class\\|def\)')<cr>zz
nnoremap <silent> <buffer> <leader>d :call <SID>Python_jump('/^\s*\(class\\|def\)')<cr>zz
nnoremap <silent> <buffer> <leader>D :call <SID>Python_jump('?^\s*\(class\\|def\)')<cr>zz

vnoremap <silent> <buffer> <leader>c :call <SID>Python_jump('/^\(class\\|def\)')<cr>zz
vnoremap <silent> <buffer> <leader>C :call <SID>Python_jump('?^\(class\\|def\)')<cr>zz
vnoremap <silent> <buffer> <leader>d :call <SID>Python_jump('/^\s*\(class\\|def\)')<cr>zz
vnoremap <silent> <buffer> <leader>D :call <SID>Python_jump('?^\s*\(class\\|def\)')<cr>zz

nnoremap <silent> <buffer> å :call <SID>Python_jump('/^\s*\(class\\|def\)')<cr>zz
nnoremap <silent> <buffer> Å :call <SID>Python_jump('?^\s*\(class\\|def\)')<cr>zz

" q in visual mode appends '#~ ' to marked lines, Q removes them
vnoremap q 0<C-v>I#~ <ESC>
vnoremap Q 0<C-v>x..<ESC>

highlight ExtraWhitespace ctermbg=darkmagenta

if exists('*<SID>Python_jump') | finish | endif

fun! <SID>Python_jump(motion) range
    let cnt = v:count1
    let save = @/    " save last search pattern
    mark '
    while cnt > 0
	silent! exe a:motion
	let cnt = cnt - 1
    endwhile
    call histdel('/', -1)
    let @/ = save    " restore last search pattern
endfun

"Start file with all folds open
"autocmd BufWinEnter *.py :%foldopen!

set foldmethod=marker
norm zi
nnoremap <cr> zizt
