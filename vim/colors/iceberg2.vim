" \_ _/ ____| ____| ___ \ ____| ___ \  ___/
"  | | |____| ____| ___ < ____| __  / |__ \
" /___\_____|_____|_____/_____|_| \_\_____/
"
"  cool-headed perspective for your coding
"
"
" File:       iceberg2.vim
" Maintainer: cocopon <cocopon@me.com> FORKED
" Modified:   2020-06-09 16:11+0900
" License:    MIT


if !has('gui_running') && &t_Co < 256
  finish
endif

set background=dark
hi clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'iceberg2'


hi! ColorColumn cterm=NONE ctermbg=235 guibg=#1e2132
hi! CursorColumn cterm=NONE ctermbg=235 guibg=#1e2132
hi! CursorLine cterm=NONE ctermbg=235 guibg=#1e2132
hi! Comment ctermfg=242 guifg=#6b7089
hi! Constant ctermfg=140 guifg=#a093c7
hi! Cursor ctermbg=252 ctermfg=234 guibg=#c6c8d1 guifg=#161821
hi! CursorLineNr ctermbg=237 ctermfg=253 guibg=#2a3158 guifg=#cdd1e6
hi! Delimiter ctermfg=252 guifg=#c6c8d1
hi! DiffAdd ctermbg=108 ctermfg=234 guibg=#555a47 guifg=#bec4b1
hi! DiffChange ctermbg=66 ctermfg=234 guibg=#445861 guifg=#adc1cb
hi! DiffDelete ctermbg=95 ctermfg=234 guibg=#673e43 guifg=#d1a8ad
hi! DiffText cterm=NONE ctermbg=116 ctermfg=234 gui=NONE guibg=#89b8c2 guifg=#161821
hi! Directory ctermfg=109 guifg=#89b8c2
hi! Error ctermbg=234 ctermfg=203 guibg=#161821 guifg=#e27878
hi! ErrorMsg ctermbg=234 ctermfg=203 guibg=#161821 guifg=#e27878
hi! WarningMsg ctermbg=234 ctermfg=203 guibg=#161821 guifg=#e27878
hi! Folded ctermbg=235 ctermfg=245 guibg=#1e2132 guifg=#686f9a
hi! FoldColumn ctermbg=235 ctermfg=239 guibg=#1e2132 guifg=#444b71
hi! Function ctermfg=216 guifg=#e2a478
hi! Identifier cterm=NONE ctermfg=109 guifg=#89b8c2
hi! LineNr ctermbg=235 ctermfg=239 guibg=#1e2132 guifg=#444b71
hi! MatchParen ctermbg=237 ctermfg=255 guibg=#3e445e guifg=#ffffff
hi! MoreMsg ctermfg=150 guifg=#b4be82
hi! NonText ctermbg=234 ctermfg=236 guibg=#161821 guifg=#242940
hi! SpecialKey ctermbg=234 ctermfg=236 guibg=#161821 guifg=#242940


hi! Normal ctermbg=233 ctermfg=252 guibg=#161821 guifg=#c6c8d1
hi! Operator ctermfg=111 guifg=#84a0c6
hi! Pmenu ctermbg=237 ctermfg=251 guibg=#3d425b guifg=#c6c8d1
hi! PmenuSbar ctermbg=237 guibg=#3d425b
hi! PmenuSel ctermbg=241 ctermfg=255 guibg=#5b6389 guifg=#eff0f4
hi! PmenuThumb ctermbg=252 guibg=#c6c8d1
hi! PreProc ctermfg=151 guifg=#b4be82
hi! Question ctermfg=151 guifg=#b4be82
hi! Search ctermbg=217 ctermfg=234 guibg=#e4aa80 guifg=#392313
hi! SignColumn ctermbg=236 ctermfg=239 guibg=#1e2132 guifg=#444b71
hi! Special ctermfg=151 guifg=#b4be82
hi! SpellBad guisp=#e27879
hi! SpellCap guisp=#85a0c6
hi! SpellLocal guisp=#90b8c2
hi! SpellRare guisp=#a094c7
hi! Statement ctermfg=111 gui=NONE guifg=#84a0c6
hi! StatusLine cterm=reverse ctermbg=235 ctermfg=245 gui=reverse guibg=#17171b guifg=#818596 term=reverse
hi! StatusLineNC cterm=reverse ctermbg=239 ctermfg=233 gui=reverse guibg=#3e445e guifg=#0f1117
hi! StorageClass ctermfg=111 guifg=#84a0c6
hi! String ctermfg=110 guifg=#89b8c2
hi! Structure ctermfg=109 guifg=#89b8c2
hi! TabLine cterm=NONE ctermbg=245 ctermfg=234 gui=NONE guibg=#818596 guifg=#17171b
hi! TabLineFill cterm=reverse ctermbg=204 ctermfg=245 gui=reverse guibg=#17171b guifg=#818596
hi! TabLineSel cterm=NONE ctermbg=204 ctermfg=252 gui=NONE guibg=#161821 guifg=#9a9ca5
hi! Title ctermfg=186 gui=NONE guifg=#e2a478
hi! Todo ctermbg=204 ctermfg=150 guibg=#161821 guifg=#d8e599
hi! Type ctermfg=79 gui=NONE guifg=#89b8c2
hi! Underlined cterm=underline ctermfg=80 gui=underline guifg=#84a0c6 term=underline
hi! VertSplit ctermbg=203 ctermfg=233 guibg=#0f1117 guifg=#0f1117
"hi! Visual ctermbg=206 guibg=#272c42
hi! Visual ctermbg=208 guibg=#272c42
hi! WildMenu ctermbg=225 ctermfg=234 guibg=#d4d5db guifg=#17171b
hi! diffAdded ctermfg=120 guifg=#b4be82
hi! diffRemoved ctermfg=173 guifg=#e27878

hi! link cssBraces Delimiter
hi! link helpHyperTextJump Constant
hi! link htmlArg Constant
hi! link htmlEndTag Statement
hi! link htmlTag Statement
hi! link jsFunction Function
hi! link markdownCode String
hi! link markdownCodeDelimiter String
hi! link markdownHeadingDelimiter Comment
hi! link markdownRule Comment
hi! link phpVarSelector Identifier
hi! link rubyDefine Statement
hi! link rubyInclude Statement
hi! link rubyInterpolationDelimiter String
hi! link rubySharpBang Comment
hi! link rubyStringDelimiter String
hi! link svssBraces Delimiter
hi! link swiftIdentifier Normal
hi! link vimContinue Comment
hi! link vimIsCommand Statement
hi! link xmlAttribPunct Statement
hi! link xmlEndTag Statement
hi! link xmlNamespace Statement
hi! link xmlTag Statement
hi! link xmlTagName Statement
hi! link yamlKeyValueDelimiter Delimiter
