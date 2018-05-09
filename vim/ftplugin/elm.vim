" Mappings {{{
"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

"nnoremap <leader>p :SyntasticCheck<cr>:ElmMake<cr>
"nnoremap <leader>p :ElmMake<cr>
"nnoremap <leader>P :!clear && elm make --warn %<cr>
nnoremap <leader>p :!clear && elm make --warn %<cr>

"nnoremap <leader>P :call ElmMakeWithWarning()<cr>
"function ElmMakeWithWarning()
"    !clear && elm make --warn %
"    ElmMake
"endfunction

nnoremap <leader><space> :update<cr>:ElmMake<cr>
nnoremap <silent> <space> :update<cr>:%s/^\(    \)\+$//ge<cr>

nnoremap <localleader>r :ElmRepl<cr><cr>
nnoremap <localleader>t :ElmTest<cr>
nnoremap <localleader>w :!clear && elm make --warn %<cr>
nnoremap <localleader>d :ElmShowDocs<cr>
nnoremap <localleader>D :ElmBrowseDocs<cr>
nnoremap <localleader>f :ElmFormat<cr>
"nnoremap K :ElmShowDocs<cr>

nnoremap <localleader>R :source ~/.vim/ftplugin/elm.vim<cr>

"}}}
" Let {{{
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_elm_checkers=['elm_make']

let g:elm_detailed_complete = 1
"let g:elm_make_show_warnings = 1
let g:elm_syntastic_show_warnings = 1
let g:elm_detailed_complete = 1
let g:elm_classic_highlighting = 1

"}}}
" Set {{{
set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

if exists('+colorcolumn')
    set colorcolumn=80
endif

"}}}

"let b:commentary_format='#~ %s'
colorscheme luna
"colorscheme iceberg

iabbrev improt import
