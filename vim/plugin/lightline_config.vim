""lightline configuration
let g:lightline = {
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ }


let g:lightline.colorscheme = 'wombat'

let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '|', 'right': '|' }
"separator = { 'left': '⮀', 'right': '⮂' }
"subseparator = { 'left': '⮁', 'right': '⮃' }

let g:lightline.active = {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'filename'],
  \             [ 'fugitive', 'modified', 'readonly']]
  \ }

let g:lightline.component = { 'filename': '%f' }
