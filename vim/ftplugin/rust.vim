"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

if has('nvim')
    "nnoremap <leader>p <c-w><c-v>:term rustc % && ./%:r<cr>
    nnoremap <leader>p <c-w><c-v>:term cargo run -q<cr>i
    nnoremap <leader>t <c-w><c-v>:term cargo test -q<cr>i
    nnoremap <leader>P <c-w><c-s>:term cargo run<cr>i
    nnoremap <leader>b <c-w><c-v>:term cargo build<cr>i
else
    nnoremap <leader>p :!cargo run -q<cr>
endif

call SuperTabSetDefaultCompletionType("<c-x><c-o>")

" nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
" nnoremap <silent> gh :call LanguageClient#explainErrorAtPoint()<CR>
" nnoremap <silent> ga :call LanguageClient#textDocument_codeAction()<CR>
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>

inoremap <localleader>d <esc>"qdiwaprintln!("<c-r>q: {}", <c-r>q)<esc>
nnoremap <localleader>d "qdiwaprintln!("<c-r>q: {}", <c-r>q);<esc>

" We can't do :update here, as coc only triggers on actual save?
nnoremap <space> :w<CR>

colorscheme lunacocmod
set cc=100
" Auto-formatting using rustfmt (rustup component add rustfmt-preview)
let g:rustfmt_autosave = 1

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> ]l <Plug>(coc-diagnostic-next)
nmap <silent> [l <Plug>(coc-diagnostic-prev)

xmap <leader>f  <Plug>(coc-codeaction-selected)
" nmap ga  <Plug>(coc-codeaction-selected)
" nmap ga  <Plug>(coc-codeaction)
nmap <leader>f  :CocAction<CR>

nmap gf  <Plug>(coc-fix-current)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

let g:coc_auto_copen = 0
