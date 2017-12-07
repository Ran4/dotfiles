set noruler

"Number of screen lines to use for the command-line. Helps avoiding hit-enter prompts
set cmdheight=1

"If in Insert, Replace or Visual mode, don't put a message on the last line
set noshowmode

" Don't show partial command in the last line of the screen
set noshowcmd

"Never show status line
set laststatus=0

"Don't show line numbers
set nonu


"The ~ character
hi NonText ctermfg=0

"hi colorcolumn ctermbg=0
hi colorcolumn ctermbg=233

hi VertSplit ctermbg=233

hi StatusLine ctermbg=233 ctermfg=230
hi StatusLineNC ctermbg=233 ctermfg=237
