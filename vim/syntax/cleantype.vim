 if exists("b:current_syntax")
     finish
 endif

syn keyword Keyword else deriving alias trait where
syn keyword Constant AWESOME
syn match Number '\d\*'
syn match Comment '--.*'

" The non-greedy version of * is \{-}
syn match String '".\{-}"'
" syn match Type '\<[ABCDEFGHIJKLMNOPQRSTUVWXYZ].\{-}\>'
syn match Type '\<\u\l\{-}\>'
syn match Macro '\w\+!\|=>'
syn match Operator '\.\|->\|::\|+\||'

let b:current_syntax = "cleantype"
