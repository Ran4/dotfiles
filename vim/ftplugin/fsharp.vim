"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

vnoremap <CR> :<C-u>call fsharpbinding#python#FsiSendSel()<CR>
nnoremap <localleader>s :FsiShow<CR>
nnoremap <localleader>c :FsiClear<CR>

nnoremap <leader>p :FsiClear<CR>:FsiEvalBuffer<CR>
nnoremap <leader>P :FsiEvalBuffer<CR>
