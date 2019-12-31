"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

" <leader>s on a line with a card name will replace that line with info for that card
" e.g. on a line containing
" Essence Capture
" then typing <leader>s will replace that text with
" Essence Capture - UU
"     Counter target creature spell. Put a +1/+1 counter on up to one target creature you control.
" ---
nnoremap <leader>d 0"td$:r!source ~/src/pyy/scry/.venv/bin/activate && echo "<c-r>t" \| python3 ~/src/pyy/scry/main.py --no-color<cr><cr>

" Requires https://github.com/Ran4/mtg-card-stats
nnoremap <leader>s :!~/other/mtg/mtg-card-stats/cardstats.py %<cr>

setlocal commentstring=#\ %s
