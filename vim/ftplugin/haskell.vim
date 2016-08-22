"remaps å¨Å^ to []{} in various ways
source ~/.vim/ftplugin/remap_to_brackets.vim

if exists('+colorcolumn')
    set colorcolumn=80
endif

if has("gui_running")
    colo luna-gvim
else
    colo luna
endif
