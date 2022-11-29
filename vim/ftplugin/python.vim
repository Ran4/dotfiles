"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

"colorscheme iceberg

" Space will strip lines-with-only-spaces-in-them, then save-if-needed (:update)
" e is added to the substitution pattern to ignore E486: Pattern not found: }\s\+$
nnoremap <space> mz:%s/^\s\+$//e<CR>`z:update<CR>

"Initially, only use the 'python' checker, which warns much less than pylint
let g:syntastic_python_checkers=['python3', 'pep8']
let g:syntastic_always_populate_loc_list = 1
"Manually set linters:
"nnoremap <leader>l :let g:syntastic_python_checkers=['python', 'pylint']
nnoremap <leader>l :let g:syntastic_python_checkers=['python3', 'pep8', 'pylint']
nnoremap <leader><leader>l :let g:syntastic_python_checkers=['python3']
"Disable pylint
nnoremap <leader>L :let g:syntastic_python_checkers=['python']<cr>

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>rn <Plug>(coc-rename)
nnoremap S :CocCommand python.sortImports<CR>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
nnoremap <leader>f :call CocAction('format')<cr>

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let g:syntastic_python_checkers=['python3', 'pep8']

" nnoremap <leader>f :!autopep8 -i --select E302 %<CR><CR>:e!<CR>:w<CR>


"nvim will auto clear
if has('nvim')
    "Use :term instead of :!, since that supports input()
    "nnoremap <leader>P :term python %<cr>
    "nnoremap <leader>p :term python3 %<cr>
    nnoremap <leader>P <c-w><c-v>:term python2 %<cr>i
    nnoremap <leader>p <c-w><c-v>:term python3 %<cr>i

    nnoremap <leader>I <c-w><c-v>:term python -i %<cr>
    nnoremap <leader>i <c-w><c-v>:term python3 -i %<cr>
else
    nnoremap <leader>P :!clear && python %<cr>
    nnoremap <leader>p :!clear && python3 %<cr>
endif

"nnoremap <leader>I :!python -i %<cr>
"nnoremap <leader>i :!python3 -i %<cr>


nnoremap <localleader>rr :source ~/.vim/ftplugin/python.vim<cr>
nnoremap <localleader>t :r ~/.vim/snippets/snippet_python3_test.py<cr>

"Turn (where | = cursor)
"    some_value|
" into
"    print("some_value:", some_value)
"and exit insert mode
inoremap <localleader>d <esc>"qdiwaprint("<c-r>q:", <c-r>q)<esc>
nnoremap <localleader>d "qdiwaprint("<c-r>q:", <c-r>q)<esc>

if exists('+colorcolumn')
    set colorcolumn=89
endif

set makeprg=python\ -u\ %
nnoremap <f5> :w:Make<cr>

"Used for the commentary.vim plugin
let b:commentary_format='#~ %s'

"Used for the vim-printf plugin
let b:printf_pattern = 'print("%{}".format(%s))'
let b:printf_delim = ': '

let g:ale_enabled = 1

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

set wildignore+=*.pyc,__pycache__

iabbrev adn and
iabbrev pritn print
iabbrev true: True:
iabbrev false: False:
iabbrev impot import

"nnoremap <silent> <buffer> ]] :call <SID>Python_jump('/^\(class\\|def\)')<cr>
"nnoremap <silent> <buffer> [[ :call <SID>Python_jump('?^\(class\\|def\)')<cr>
nnoremap <silent> <buffer> ]m :call <SID>Python_jump('/^\s*\(class\\|def\)')<cr>
nnoremap <silent> <buffer> [m :call <SID>Python_jump('?^\s*\(class\\|def\)')<cr>
nnoremap <silent> <buffer> ¨¨ :call <SID>Python_jump('/^\s*\(class\\|def\)')<cr>
nnoremap <silent> <buffer> åå :call <SID>Python_jump('?^\s*\(class\\|def\)')<cr>
"nmap <silent> <buffer> å :call <SID>Python_jump('?^\s*\(class\\|def\)')<cr>
"nmap <silent> <buffer> ¨ :call <SID>Python_jump('/^\s*\(class\\|def\)')<cr>

vnoremap <silent> <buffer> ¨¨ j$/^\s*\(class\\|def\)<cr>k
vnoremap <silent> <buffer> åå ?^\s*\(class\\|def\)<cr>k

"Delete until next def or class (not including the next def or class)
nnoremap d¨¨ d/^\s*\(class\\|def\)<cr>

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
"nnoremap <cr> zizt

" call deoplete#enable()
" let g:deoplete#enable_at_startup = 1
