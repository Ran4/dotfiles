
if !exists('main_syntax')
  let main_syntax = 'mtg'
endif

syn keyword identifier Creatures: Planeswalkers: Instants: Enchantments: Artifacts: Equipment: Lands:
syn keyword keyword Flying Haste Flash Defender Proliferate amass Amass Hexproof hexproof Deatchtouch Jumpstart Replicate

" Anything starting with # is a comment until end of line
syn match comment "\v#.*$"

highlight def link keyword Keyword
highlight def link identifier Identifier
highlight def link comment Comment
