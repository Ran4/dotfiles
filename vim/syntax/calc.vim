" Vim syntax file
" Language:     CalculationLanguage
" Maintainer:   Rasmus Ansin
" Filenames:    *.calc
" 
if exists("b:current_syntax")
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'calc'
endif

unlet! b:current_syntax


" comment
" syn match Number "-\?[0-9_]\+\(\.[0-9_]\+\)\?k\?"
syn match Number "-\?[0-9_]\?\(\.[0-9_]\+\)\?[km]\?"
syn match Operator "[=+]"
syn match calcDefinition "[a-zåäö0-9]\+:"
syn match calcComment "#.*"

hi def link calcDefinition String
hi def link calcComment Comment

let b:current_syntax = "calc"
