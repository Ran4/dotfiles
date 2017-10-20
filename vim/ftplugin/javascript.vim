set shiftwidth=2
set softtabstop=2 "Number of spaces in tab when editing

if has('nvim')
    "Use :term instead of :!, since that supports input()
    nnoremap <leader>p <c-w><c-v>:term node %<cr>:q
    " nnoremap <leader>p :!node %<cr>
else
    nnoremap <leader>p :!clear && node %<cr>
endif

inoremap <localleader>l console.log();<left><left>

"hello´d -> console.log("hello: " + hello);
inoremap <localleader>d <esc>"qdiwaconsole.log("<c-r>q:", <c-r>q);
nnoremap <localleader>d "qdiwaconsole.log("<c-r>q:", <c-r>q);<esc>

" fs´q -> var fs = require("fs");
inoremap <localleader>q <esc>"qdiwavar <c-r>q = require("<c-r>q");
nnoremap <localleader>q "qdiwavar <c-r>q = require("<c-r>q");<esc>

nnoremap gd :TernDef<cr>
nnoremap <localleader>t :TernType<cr>
nnoremap <localleader>r :TernRefs<cr>
nnoremap <localleader>R :TernRename<cr>

" colo luna
" colo iceberg

if exists('+colorcolumn')
    set colorcolumn=80
endif

"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

iabbrev cll console.log

" Enable syntax highlighting for Flow (the Facebook typechecker)
let g:javascript_plugin_flow = 1

"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

let g:deoplete#enable_at_startup = 1

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
\ 'tern#Complete',
\ 'jspc#omni'
\]
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

" let g:deoplete#sources#ternjs#timeout = 1
" 
" " Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#types = 1
" 
" " Whether to include the distance (in scopes for variables, in prototypes for 
" " properties) between the completions and the origin position in the result 
" " data. Default: 0
" let g:deoplete#sources#ternjs#depths = 1
" 
" " Whether to include documentation strings (if found) in the result data.
" " Default: 0
let g:deoplete#sources#ternjs#docs = 1
" 
" " When on, only completions that match the current word at the given point will
" " be returned. Turn this off to get all results, so that you can filter on the 
" " client side. Default: 1
" let g:deoplete#sources#ternjs#filter = 0
" 
" " Whether to use a case-insensitive compare between the current word and 
" " potential completions. Default 0
" let g:deoplete#sources#ternjs#case_insensitive = 1
" 
" " When completing a property and no completions are found, Tern will use some 
" " heuristics to try and return some properties anyway. Set this to 0 to 
" " turn that off. Default: 1
" let g:deoplete#sources#ternjs#guess = 0
" 
" " Determines whether the result set will be sorted. Default: 1
" let g:deoplete#sources#ternjs#sort = 0
" 
" " When disabled, only the text before the given position is considered part of 
" " the word. When enabled (the default), the whole variable name that the cursor
" " is on will be included. Default: 1
" let g:deoplete#sources#ternjs#expand_word_forward = 0
" 
" " Whether to ignore the properties of Object.prototype unless they have been 
" " spelled out by at least to characters. Default: 1
" let g:deoplete#sources#ternjs#omit_object_prototype = 0
" 
" " Whether to include JavaScript keywords when completing something that is not 
" " a property. Default: 0
" let g:deoplete#sources#ternjs#include_keywords = 1
" 
" " If completions should be returned when inside a literal. Default: 1
" let g:deoplete#sources#ternjs#in_literal = 0


"Add extra filetypes
"let g:deoplete#sources#ternjs#filetypes = [
"    \ 'jsx',
"    \ 'javascript.jsx',
"    \ 'vue',
"    \ ]
