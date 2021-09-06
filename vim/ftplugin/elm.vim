" Mappings {{{
"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

" The elm languageserver doesn't seem to like using update?
nnoremap <space> :w<CR>

if exists('+colorcolumn')
    set colorcolumn=90
endif

"let b:commentary_format='#~ %s'
colorscheme luna
"colorscheme iceberg

iabbrev improt import

let g:ale_pattern_options = {'\.Elm$': {'ale_enabled': 0}}
