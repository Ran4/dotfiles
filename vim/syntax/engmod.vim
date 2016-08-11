" Vim syntax file
" Language:     engmod
" Maintainer:   Rasmus Ansin
" Filenames:    engmod*
" Last Change:  2016-07-11

"if exists("b:current_syntax")
"  finish
"endif

if !exists('main_syntax')
  let main_syntax = 'engmod'
endif

"syn keyword basicKeyWord ≡
syn keyword objects Zo Pe Alice Bob Charlie Dennis X Y Z I you
"syn keyword operators position time i t o ö :o :ot :oti :ti
syn keyword operators position time
syn keyword mid where
syn match operators "[ö\.:\\]\+[otixdö\.:\\]*"

hi def link objects Keyword
hi def link mid Identifier
hi def operators String
"hi operators  ctermfg=152
