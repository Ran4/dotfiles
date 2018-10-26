"{{{ MAPPINGS

let mapleader = "ä"
let maplocalleader = "´"
nmap , ä
nmap ö <localleader>
nnoremap ,, ,

" Ugly hack since OS X is terrible at not breaking this...
if has("macunix")
    map § <
    map ° >
    map f§ f<
    map f° f>
    map F§ F<
    map F° F>
    map t§ t<
    map t° t>
    map T§ T<
    map T° T>
    imap § <
    vmap § <
endif

nmap cså cs[
nmap cs¨ cs]
omap iå i[
omap i¨ i]
omap aå a[
omap a¨ a]

nmap å [
nmap ¨ ]


nnoremap di_ f_dF_
nnoremap vi_ t_vF_
vnoremap i_ F_

"Helper for spell check: press <tab> on a word, <esc> to choose word
nmap <s-tab> viw<esc>a<c-x>s<tab>
"nmap <s-tab> viw<esc>a<c-x>s
nnoremap gsus :set spell spelllang=en_us<cr>
nnoremap gsgb :set spell spelllang=en_gb<cr>
nnoremap gss :set nospell<cr>

"Buffer shortcuts: open new, next, prev, delete
nnoremap <b :b <c-d>
nnoremap <l :lnext<cr>
nnoremap >L :lprevious<cr>
nnoremap <n :cn<cr>
nnoremap <p :cp<cr>
nnoremap <d :bd<cr>

" Adds characters around word
nnoremap <leader>" viw<ESC>a"<ESC>hbi"<ESC>lel
nnoremap <leader>' viw<ESC>a'<ESC>hbi'<ESC>lel
vnoremap <leader>" <ESC>`>a"<ESC>`<i"<ESC>
vnoremap <leader>' <ESC>`>a'<ESC>`<i'<ESC>
nnoremap <leader>[ viw<ESC>a]<ESC>hbi[<ESC>%
nnoremap <leader>] viw<ESC>a]<ESC>hbi[<ESC>%
nnoremap <leader>( viw<ESC>a)<ESC>hbi(<ESC>%
nnoremap <leader>) viw<ESC>a)<ESC>hbi(<ESC>%
nnoremap <leader>< viw<ESC>a><ESC>hbi<<ESC>%
nnoremap <leader>> viw<ESC>a><ESC>hbi<<ESC>%

nnoremap <leader>n :bn<cr>
nnoremap <leader>N :bp<cr>

" Quickly edit vimrc
nnoremap <leader>ev :vert split $MYVIMRC<CR>
nnoremap <leader>Ev :split $MYVIMRC<CR>
nnoremap <leader>EV :split $MYVIMRC<CR>
"yank current line and enter it into command mode without pressing enter
nnoremap <leader>: 0"xy$:<c-r>x

nnoremap <leader>ei :vert split ~/.i3/config<CR>

nnoremap <leader><leader>n :set number!<CR>
nnoremap <leader><leader>p :set paste<cr>"+p:set nopaste<cr>

inoremap <c-r>+ :set paste<cr>a<c-r>+:set nopaste<cr>a
inoremap <c-r>* :set paste<cr>a<c-r>*:set nopaste<cr>a

" Prepends # to line and goes down, Q removes then
nnoremap <leader>q I#<esc>j
nnoremap <leader>Q kx

"add space around character, e.g. '*' -> ' * '
nnoremap <leader><space> i<space><esc>2li<space><esc>h
vnoremap <space> <esc>`<i<space><esc>`>la<space><esc>`<l

" Substitution  helper: press <leader>vname/newname<CR> to replace globally
nnoremap <leader>s :%s//gc<Left><Left><Left>
" visual mode replace helper
vnoremap <leader>s :s/\%V/g<Left><Left>
vnoremap <leader>s :s//g<Left><Left>
" Search for something first (e.g. using *), then press S to substitute
nnoremap S :%s///g<left><left>

"Resize window
"nnoremap <leader>r :vert resize 84<CR>
"nnoremap <leader>R :vert resize 80<CR>
nnoremap <silent> <Leader><Leader>+ :exe "resize " . (winheight(0) * 3/2)<cr>
nnoremap <silent> <Leader><Leader>- :exe "resize " . (winheight(0) * 2/3)<cr>
nnoremap <silent> <Leader>+ :exe "vert resize " . (winwidth(0) * 3/2)<cr>
nnoremap <silent> <Leader>- :exe "vert resize " . (winwidth(0) * 2/3)<cr>

":update will save but only if there's a change
"nnoremap <space> :w<CR>
nnoremap <space> :update<CR>
" press <backspace> to switch to the "alternate file"
nnoremap <bs> <C-^>
" <cr> does za, but only in regular buffers
" (found at https://www.reddit.com/r/vim/comments/4m678o/best_way_to_remap_cr_in_normal_mode/ )
"" nnoremap <silent> <expr> <CR> empty(&buftype) \|\| &bt ==# 'help' \|\| &ft ==# 'man' ?
""                               \ 'za' : '<CR>'

"nnoremap <silent> <expr> <CR> empty(&buftype) \|\| &bt ==# 'help' \|\| &ft ==# 'man' ?
"                              \ '<Plug>(easymotion-s)' : '<CR>'


nnoremap <silent> <expr> <CR> empty(&buftype) \|\| &bt ==# 'help' \|\| &ft ==# 'man' ?
                              \ (&ft ==# 'fsharp' ? ':<C-u>call fsharpbinding#python#FsiSendLine()<CR>' : '<Plug>(easymotion-s)') : '<CR>'

" nnoremap <buffer> <CR> :<C-u>call fsharpbinding#python#FsiSendLine()<CR>



nnoremap + <c-a>
nnoremap - <c-x>

" :help map-which-keys    " is helpful to find new mappings
imap jk <esc>
imap Jk <esc>
"nnoremap ö /
"nnoremap dö d/
"cnoremap ö /
"vnoremap ö /
"nnoremap E $
"noremap L $
"nnoremap H ^

" We're more often interested in completing previous command rather than
" seeing the previous one
cnoremap <c-a> <home>
cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <up> <c-p>
cnoremap <down> <c-n>

"An equivalent of <c-r><c-w>/<c-r><c-f> for the current line:
cnoremap <C-r><C-l> <C-r>=getline('.')<CR>

"Don't wait as long in insert mode (to enable us to quickly type j and k)
if has("autocmd")
    augroup FastEscape
        autocmd!
        autocmd InsertEnter * set timeoutlen=450
        autocmd InsertLeave * set timeoutlen=2500
    augroup END
endif

"Fix accidentally holding shift while trying to quit vim, e.g. :Q -> :q
command Q q
command Qa qa
command QA qa
cmap Q! q!
cmap Qa! qa!
cmap QA! qa!

"helper
cmap FTP ~/.vim/ftplugin/<c-d>
cmap BUN ~/.vim/bundle/<c-d>
cmap US ~/.vim/bundle/vim-snippets.git/snippets/<c-d>

nnoremap - /

"0 is much easier to reach than ^ on many non-US layouts
nnoremap 0 ^
nnoremap ´ ^
nnoremap ^ 0
nnoremap d0 d^
nnoremap c0 c^
nnoremap y0 y^

" More reasonable use of Y (as opposed to being identical to yy)
nnoremap Y y$

" Jump directly to a spot instead of just to that line
nnoremap ` '
nnoremap ' `
vnoremap ` '
vnoremap ' `

nnoremap Q :q
nnoremap QQ Q

" Quickly replay a record
"nnoremap Q @q

"Quickly move between windows with ctrl+hjkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

if has('nvim')
    """ Disabled to get c-s to work with fzf.vim's Ag command
    """ "Terminal mappings, since <C-\><C-n> is annoying to prepend
    """ tnoremap <c-s> <C-\><C-n>
    """ tnoremap <c-s><c-s> <C-\><C-n><c-w><c-c>
    """ tnoremap <c-s><c-h> <C-\><C-n><c-w>h
    """ tnoremap <c-s><c-j> <C-\><C-n><c-w>j
    """ tnoremap <c-s><c-k> <C-\><C-n><c-w>k
    """ tnoremap <c-s><c-l> <C-\><C-n><c-w>l
    """ tnoremap <c-s>h <C-\><C-n><c-w>h
    """ tnoremap <c-s>j <C-\><C-n><c-w>j
    """ tnoremap <c-s>k <C-\><C-n><c-w>k
    """ tnoremap <c-s>l <C-\><C-n><c-w>l
    """ 
    """ 
    """ " Recreating some tmux-like stuff
    """ tnoremap <c-s>c <C-\><C-n>:tabe<cr>:term<cr>
    """ "In case we're not releasing ctrl quickly enough:
    """ tnoremap <c-s><c-c> <C-\><C-n>:tabe<cr>:term<cr>
    """ tnoremap <c-s>n <C-\><C-n>gt
    """ tnoremap <c-s><c-n> <C-\><C-n>gt
    """ tnoremap <c-s>p <C-\><C-n>gT
    """ tnoremap <c-s><c-p> <C-\><C-n>gT
    """ tnoremap <c-s>s <C-\><C-n>:new<cr>:term<cr>
    """ tnoremap <c-s><c-s> <C-\><C-n>:new<cr>:term<cr>
    """ tnoremap <c-s>v <C-\><C-n>:vnew<cr>:term<cr>
    """ tnoremap <c-s><c-v> <C-\><C-n>:vnew<cr>:term<cr>
    """ tnoremap <c-s>x <C-\><C-n><c-w>c
    """ tnoremap <c-s><c-x> <C-\><C-n><c-w>c
    """ tnoremap <c-s>T <C-\><C-n><c-w>T
    """ 
    """ nnoremap <c-s>c :tabe<cr>:term<cr>
    """ "In case we're not releasing ctrl quickly enough:
    """ nnoremap <c-s><c-c> :tabe<cr>:term<cr>
    """ nnoremap <c-s>n gt
    """ nnoremap <c-s><c-n> gt
    """ nnoremap <c-s>p gT
    """ nnoremap <c-s><c-p> gT
    """ nnoremap <c-s>s :new<cr>:term<cr>
    """ nnoremap <c-s><c-s> :new<cr>:term<cr>
    """ nnoremap <c-s>v :vnew<cr>:term<cr>
    """ nnoremap <c-s><c-v> :vnew<cr>:term<cr>
    """ nnoremap <c-s>x <c-w>c
    """ nnoremap <c-s><c-x> <c-w>c
    """ nnoremap <c-s>T <c-w>T
    """ 
    """ 
    """ 
    """ "tnoremap <c-h> <c-\><c-n><c-w>h
    """ "tnoremap <c-j> <c-\><c-n><c-w>j
    """ "tnoremap <c-k> <c-\><c-n><c-w>k "used for kill to eol
    """ "tnoremap <c-l> <c-\><c-n><c-w>l "used for clear...
    """ 
    """ 
    """ "Open a new vertical term
    """ nnoremap <c-t> :vnew<cr>:term<cr>
    """ 
    """ nnoremap <c-s><c-h> <c-w>h
    """ nnoremap <c-s><c-j> <c-w>j
    """ nnoremap <c-s><c-k> <c-w>k
    """ nnoremap <c-s><c-l> <c-w>l
    """ nnoremap <c-s>h <c-w>h
    """ nnoremap <c-s>j <c-w>j
    """ nnoremap <c-s>k <c-w>k
    """ nnoremap <c-s>l <c-w>l
    """ 
    """ "Automatically enter terminal if we go into term window
    """ autocmd BufEnter term://* startinsert
endif

" o and O doesn't go into insert mode
nnoremap o o.<Esc>"_x<Esc>
nnoremap O O.<Esc>"_x<Esc>

" Characters to use with ¨ and shift+¨
" ẅëẗÿüï¨ḧ̈́̈́ẍ^f
" âĉêĝĥîĵôŝûŵŷẑ
nnoremap ü i<CR><Esc>k$
nnoremap ë :vert resize 80<CR>
nnoremap Ω :vert resize 80<CR>
"Key that is right of + on Swedish keyboards plus key gives these
nnoremap ẃ :mksession! .vimsession<cr>
nnoremap ŕ :source .vimsession<cr>

" Move top/bottom but leave 4 lines above/below
nnoremap zT zt4<C-y>
nnoremap zB zb4<C-e>
vnoremap zT zt4<C-y>
vnoremap zB zb4<C-e>
"inoremap zT <esc>zt4<C-y>i
"inoremap zB <esc>zb4<C-e>i

" Move vertically by visual line
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Inverse of join (J)
"function! BreakHere()
"    s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
"    call histdel("/", -1)
"endfunction
"nnoremap K :call BreakHere()<CR>

" Easier indentation in visual mode (don't leave visual mode after < or >)
vnoremap < <gv
vnoremap > >gv

"}}}
"{{{ SET OPTIONS
filetype plugin indent on

if has('nvim')
    let $LANG = 'en'
    set langmenu=none

    "Show :substitute substitutions in new split
    set inccommand=split
endif

"set completeopt=menu,preview,noinsert
set completeopt=menu,preview,longest

set number "show line numbers
"set relativenumber

set shiftwidth=4
set softtabstop=4 "Number of spaces in tab when editing

" Use the same symbols as TextMate for tabstops and EOLs
set list
"set listchars=tab:▸▸,eol:¬
set listchars=tab:▸▸
"set listchars=tab:▸▸,trail:·
set fillchars=
set expandtab "Expands tabs into spaces

highlight SpellBad ctermbg=5

"set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize

set bs=2 "Enable backspace to go past indent,eol,start

set foldmethod=marker

set splitbelow
set splitright

"Reload a file if it has been modified outside of vim
set autoread

"Read local .vimrc files
set exrc

" F bindings
" Disable help with f1 (mac touchbars are no fun...)
map <f1> <nop>
" <F10> identifies the syntax highlighting group used at the cursor
" See http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"Toggles paste mode
set pastetoggle=<leader>t

"Fixes slow responsiveness when scrolling in terms like iTerm(?)
"set lazyredraw

set incsearch "search as characters are entered
set ignorecase "ignore case when searching
set smartcase "ignore case when searching, except if we start with a capital
set hlsearch
if has("gui_running")
    set mouse=a "use mouse in all modes
    set guioptions-=T "removes toolbar
    set guioptions-=m "removes menu
    set guioptions-=l "removes always-on left-hand scrollbar
    set guioptions-=L "removes left-hand scrollbar when there's a vertically split window
    set guioptions-=r "removes always-on right-hand scrollbar
    set guioptions-=e "removes GUI tab pages
    "Visual bell causes the entire screen to flash in an annoying fashion
    set novisualbell
    set t_vb=
    if has("gui_macvim")
        set guifont=Menlo\ Regular:h13
    else
        " set guifont=Monospace\ Regular\ 10
        set guifont=Inconsolata\ 11
    endif
    "set guifont=
    set antialias

    nnoremap <leader><leader>1 :set guifont=Terminus\ 9<cr>
    nnoremap <leader><leader>2 :set guifont=Terminus\ 10<cr>
    nnoremap <leader><leader>3 :set guifont=Terminus\ 11<cr>
    nnoremap <leader><leader>4 :set guifont=Terminus\ 13<cr>
    nnoremap <leader><leader>5 :set guifont=Terminus\ 14<cr>
    nnoremap <leader><leader>6 :set guifont=Terminus\ 16<cr>

    "Quickly write and quit from insert mode.
    "Good with the itsalltext Firefox plugin
    "inoremap <s-cr> <esc>ZZ
else
    "set mouse=n "only use mouse in visual mode
    set mouse=
    if !has('nvim')
        set ttymouse=xterm2 "xterm2 to support resizing with mouse
    endif

    " workaround: enables mouse resize but helps with accidental clicks moving
    " the cursor
    "nnoremap <LeftMouse> m'<LeftMouse>
    "nnoremap <LeftRelease> <LeftRelease>g``set guifont=Menlo\ Regular:h14
endif

set timeout
set timeoutlen=2500 " used with e.g. leader
set ttimeoutlen=10

set wildmode=longest,list,full

set history=1000

set laststatus=2 "always show statusbar. 1 means 'only when 2+ windows open'

"always keep at a few lines at the top/bottom shown when moving around
set scrolloff=4

"Show this char when wrapping text
set showbreak=↪

"Disable Bram's start message
set shortmess+=I
"}}}
"{{{ COLORS AND HIGHLIGHTING
set t_Co=256
" mkdir -p ~/.vim/colors
" cd ~/.vim/colors
" wget -O ~/.vim/colors/wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
"color wombat256mod
if !empty(glob("/home/ran/.identifiers/virtualbox"))
    color iceberg
else
    color wombat256mod-darker
endif
"au FileType elm colorscheme predawn
"au FileType elm colorscheme github

" set background=dark
" colorscheme luna
" colorscheme wintersday
" colorscheme breeze_ranmod
" colorscheme obsidian
" colorscheme solarized
" colorscheme harlequin
syntax enable

" highlight trailing spaces. <leader>h to start highlight, <leader>H to stop.
nmap <leader>h :highlight ExtraWhitespace ctermbg=red<CR>:match ExtraWhiteSpace /\S\(\s\+\)$/<CR>
nmap <leader>H :highlight clear ExtraWhitespace<cr>
"highlight current line in insert mode
if has("autocmd")
    augroup whitespace
        autocmd!
        "autocmd InsertEnter * set cursorline! | match ExtraWhitespace //
        "autocmd InsertLeave * set cursorline! | call HighlightExtraWhitespace()
        autocmd InsertEnter * set cursorline
        autocmd InsertLeave * set nocursorline
    augroup END
endif


function! HighlightExtraWhitespace()
    "highlight ExtraWhitespace ctermbg=red
    "6 is a blue color?
    highlight ExtraWhitespace ctermbg=6
    match ExtraWhiteSpace /\S\(\s\+\)$/
endfunction

if exists('+colorcolumn')
    "Set a default colorcolumn
    set colorcolumn=110

    " Show remaining text as red when over colorcolumn columns:
    " au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"highlight Search term=none ctermfg=0 ctermbg=180
highlight Search ctermfg=0 ctermbg=180

"Left side statusline:
set statusline= "First clear statusline
"set statusline+=%t " file name (tail) of the file in the buffer
set statusline+=%f " full file name of the file in the buffer
set statusline+=\ %m%r "Modified [+]/[-], readonly [RO]
set statusline+=%w "Preview window flag [Preview]
set statusline+=%= "Start of right side statusline
"Right side statusline:
" set statusline+=%{fugitive#head()}
set statusline+=\ %y "Filetype e.g. [elm]
set statusline+=\ [col\ %02c] "Column number
set statusline+=\ %02p%% "Percent through file
set statusline+=\ %03l/%03L "Cursor line/total lines
"}}}
"{{{ FUNCTIONS

nnoremap di( :call New_dib()<CR>
nnoremap di) :call New_dib()<CR>
nnoremap dib :call New_dib()<CR>
"di(, di), dib that will move inside first instance of () first if needed
function! New_dib()
    if search("(","bn") == line(".")
        sil exe "normal! f)di("
        "sil exe "normal! l"
    else
        sil exe "normal! f(di("
        "sil exe "normal! l"
    endif
endfunction

nnoremap di{ :call New_diB()<CR>
nnoremap di} :call New_diB()<CR>
nnoremap diB :call New_diB()<CR>
"Like dib but } instead of )
function! New_diB()
    if search("{","bn") == line(".")
        sil exe "normal! f}di{"
        "sil exe "normal! l"
    else
        sil exe "normal! f{di{"
        "sil exe "normal! l"
    endif
endfunction

nnoremap ci( :call New_cip()<CR>
nnoremap ci) :call New_cip()<CR>
nnoremap cib :call New_cip()<CR>
" Change in paranthesis function, since ci( initially doesn't work
function! New_cip()
    if search("(","bn") == line(".")
        sil exe "normal! f)ci("
        sil exe "normal! l"
        startinsert
    else
        sil exe "normal! f(ci("
        sil exe "normal! l"
        startinsert
    endif
endfunction

nnoremap ci( :call New_cip()<CR>
nnoremap ci) :call New_cip()<CR>
nnoremap cib :call New_cip()<CR>

" Change in square brackets function, since ci[ initially doesn't work
function! New_cisb()
    if search("[","bn") == line(".")
        sil exe "normal! f]ci["
        sil exe "normal! l"
        startinsert
    else
        sil exe "normal! f[ci]"
        sil exe "normal! l"
        startinsert
    endif
endfunction

nnoremap ci[ :call New_cisb()<CR>
nnoremap ci] :call New_cisb()<CR>

" Change in squigly brackets function, since ci{ initially doesn't work
function! New_cisqb()
    if search("{","bn") == line(".")
        sil exe "normal! f}ci{"
        sil exe "normal! l"
        startinsert
    else
        sil exe "normal! f{ci}"
        sil exe "normal! l"
        startinsert
    endif
endfunction

nnoremap ci{ :call New_cisqb()<CR>
nnoremap ciB :call New_cisqb()<CR>
nnoremap ci} :call New_cisqb()<CR>
nnoremap cis :call New_cisqb()<CR>

" Removes trailing spaces
function! TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

nnoremap <leader>w :call TrimWhiteSpace()<CR>
"}}}
"{{{ AUTOCMDS
if has("autocmd")
    augroup bufstuff
        autocmd!
        autocmd BufRead,BufNewFile .bash_aliases,bash_aliases set filetype=sh
        autocmd BufRead,BufNewFile .pyre_configuration set ft=json
        autocmd BufRead,BufNewFile *.arff set filetype=arff

        "autocmd BufRead,BufNewFile * call HighlightExtraWhitespace()

        "Prevent auto-comments
        "c: Auto-wrap comments using textwidth, autoinserting the current comment leader
        "r: Autoinsert the current comment leader after hitting <CR> in Insert mode.
        "o: Autoinsert the current comment leader after hitting o/O in Normal mode.
        autocmd BufNewFile,BufWinEnter * setlocal formatoptions-=cro
        "set formatoptions-=cro "this won't work, will be owerwritten, see this link:
        "http://stackoverflow.com/questions/6076592/vim-set-formatoptions-being-lost

    augroup END

    " Resize splits when the window is resized
    au VimResized * exe "normal! \<c-w>="
endif
"}}}
"{{{ PLUGINS
"cd ~/.vim/bundle
"""{{{ abcdef
"abnf - Agumented BNF syntax script
"!git clone https://github.com/vim-scripts/abnf ~/.vim/bundle/abnf
"vim-abolish, a plugin that does many things
"!git clone https://github.com/tpope/tpope-vim-abolish ~/.vim/bundle/tpope-vim-abolish

"Ack plugin for vim, usagE: :Ack [options] {pattern} [{directories}]
"!git clone https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack.vim

"Ale, Asynchronous Lint Engine for Neovim
"!git clone https://github.com/w0rp/ale.git ~/.vim/bundle/ale.git

"""commentary.vim - comment things out with gc+{motion} and more
"!git clone https://github.com/tpope/vim-commentary ~/.vim/bundle/vim-commentary

"""vim-css3-syntax - better syntax highlighting (also see ~/.vim/after/ftplugin/css.vim)
"!git clone https://github.com/hail2u/vim-css3-syntax ~/.vim/bundle/vim-css3-syntax

"""dracula-theme, a colortheme
"!git clone https://github.com/dracula/vim.git ~/.vim/bundle/dracula-theme

"""editorconfig-vim
"!git clone https://github.com/editorconfig/editorconfig-vim ~/.vim/bundle/editorconfig-vim

"""elm-vim - Elm support for Vim
"!git clone https://github.com/elmcast/elm-vim.git ~/.vim/bundle/elm-vim

"""eunuch.vim - vim sugar for multiple UNIX shell commands like :Move, :Rename
"!git clone https://github.com/tpope/vim-eunuch ~/.vim/bundle/vim-eunuch

""{{{ Clojure plugins
"""Clojure runtime files, extracted from the VimClojure project, required for vim-clojure-highlight
""!git clone https://github.com/guns/vim-clojure-static ~/.vim/bundle/vim-clojure-highlight

"""Quasi-REPL for clojure
""!git clone https://github.com/tpope/vim-fireplace ~/.vim/bundle/vim-fireplace

""clojure-highlight gives extended syntax highlightinging for clojure
""!git clone https://github.com/guns/vim-clojure-highlight ~/.vim/bundle/vim-clojure-highlight
""}}}

"""ctrl-p is a fuzzy file finder
"!git clone https://github.com/ctrlpvim/ctrlp.vim ~/.vim/bundle/ctrlp.vim

"""easy-motion
"!git clone https://github.com/easymotion/vim-easymotion ~/.vim/bundle/vim-easymotion

""exchange: add the cx operator. I.e. cxe on one word, then cxe to exchange
"!git clone git://github.com/tommcdo/vim-exchange.git

""fzf.vim enables some fzf commands such as :Ag or :Files
"!git clone https://github.com/junegunn/fzf.vim ~/.vim/bundle/fzf.vim

""vim-fsharp includes syntax + indent + pathogen/synastic autocompletion for F#
"!git clone https://github.com/fsharp/vim-fsharp ~/.vim/bundle/vim-fsharp

"""}}}
"""{{{ ghijk
"""gitgutter shows a git diff in the 'gutter' (sign column)
"!git clone git://github.com/airblade/vim-gitgutter.git ~/.vim/bundle/vim-gitgutter

"""haskell-vim, a bunch of scripts for Haskell and Cabal
"!git clone https://github.com/neovimhaskell/haskell-vim.git ~/.vim/bundle/haskell-vim

"""incsearch incrementally highlights all pattern being matched.
"!git clone https://github.com/haya14busa/incsearch.vim ~/.vim/bundle/incsearch.vim

"""vim-indent-object, e.g. vii to visually select at same indentation (also vai)
"!git clone https://github.com/michaeljsmith/vim-indent-object ~/.vim/bundle/vim-indent-object

"""vim-javascript, improved syntax highlighting and improved indentation
"!git clone https://github.com/pangloss/vim-javascript.git ~/.vim/bundle/vim-javascript

"""jspc - JavaScript Parameter Complete
"!git clone https://github.com/othree/jspc.vim ~/.vim/bundle/jspc.vim

"""jedi-vim is a vim-binding to the autocompletion library Jedi
"!git clone --recursive https://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim
"""}}}
"""{{{ lmnop
"""lightline.vim is a light and configurable statusline/tabline for Vim.
"!git clone https://github.com/itchyny/lightline.vim ~/.vim/bundle/lightline.vim

"""vim-mark, clone of the 'Mark.vim' plugin, allows highlighting of words
"!git clone https://github.com/Yggdroot/vim-mark ~/.vim/bundle/vim-mark

"""matchit increases support for %. For example, jump between <tags> </tags>
"!git clone https://github.com/tmhedberg/matchit ~/.vim/bundle/matchit

"""vim-printf, turn lines into printf statements
"!git clone git://github.com/mptre/vim-printf ~/.vim/bundle/vim-printf
"""}}}
"""{{{ qrstu
""repeat - helper plugin that enables repetition with dot in plugins such as vim-surround
"!git clone git://github.com/tpope/vim-repeat.git ~/.vim/bundle/vim-repeat

""vim-markdown, Markdown runtime files
"!git clone https://github.com/tpope/vim-markdown  ~/.vim/bundle/vim-markdown

""" notational-fzf-vim adds the :NV command to search in markdown (requires fzf and configured fzf.vim)
""!git clone https://github.com/Alok/notational-fzf-vim ~/.vim/bundle/notational-fzf-vim

"rsi, adds 'readline-style-insertions' to command and insert mode
"!git clone https://github.com/tpope/vim-rsi.git ~/.vim/bundle/vim-rsi

""rust.vim
"!git clone --depth=1 https://github.com/rust-lang/rust.vim.git ~/.vim/bundle/rust.vim

""speeddating.vim, make <c-a> <c-x> support dates
"!git clone https://github.com/tpope/vim-speeddating ~/.vim/bundle/vim-speeddating

""supertab, adds <Tab> for tab completion
"!git clone git://github.com/ervandew/supertab ~/.vim/bundle/supertab

""syntastic, inline syntax checking for vim
"!git clone https://github.com/scrooloose/syntastic.git ~/.vim/bundle/syntastic

""surround: use e.g. ds( to delete surrounding (
"!git clone git://github.com/tpope/vim-surround.git

""swift.vim, syntax+indent files for Swift
"!git clone git://github.com/keith/swift.vim ~/.vim/bundle/swift.vim

""targets.vim allows movements like cin" (change in next ") and da,
"!git clone git://github.com/wellle/targets.vim.git ~/.vim/bundle/targets.vim

""tbone allows tmux commands
"!git clone git://github.com/tpope/vim-tbone.git

""tern_for_vim
"!git clone https://github.com/ternjs/tern_for_vim ~/.vim/bundle/tern_for_vim

""vim-toml, adds syntax support for TOML files
"!git clone https://github.com/cespare/vim-toml ~/.vim/bundle/vim-toml

""unimpaired - add a bunch of handy bracket mappings
"!git clone https://github.com/tpope/vim-unimpaired ~/.vim/bundle/vim-unimpaired

"""}}}
"""{{{ vwxyz
""vertical move, adds a vertical move motion to move without changing the cursor column
"!git clone git://github.com/bruno-/vim-vertical-move.git ~/.vim/bundle/vim-vertical-move

""visual-star-search, allows * operator on visual words (and <leader>* to vimgrep)
"!git clone https://github.com/bronson/vim-visual-star-search ~/.vim/bundle/vim-visual-star-search

""vim-vue, syntax highlighting for Vue.js components
"!git clone https://github.com/posva/vim-vue.git ~/.vim/bundle/vim-vue

""fugitive is a git plugin
"!git clone git://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive

"!git clone https://github.com/bronson/vim-trailing-whitespace ~/.vim/bundle/vim-trailing-whitespace
"""}}}

"Rebuild help tags (comes with pathogen): should be done after any new install
"tag: update docs update documentation
":Helptags

"PLUGIN CONFIGURATION {{{

"ALE configuration
map <leader>f <Plug>(ale_fix)

let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_linters = {
\   'python': [
\       'pylint',
\   ],
\}
let g:ale_python_pylint_executable = 'pylint'
let g:ale_python_pylint_options="--rcfile=~/.pylintrc"

let g:ale_fixers = {
\   'javascript': [
\       'remove_trailing_lines',
\       'eslint',
\   ],
\ }

"Neovim-specific:
if has('nvim')
    if has("macunix")
        let g:python_host_prog = '/usr/local/bin/python2'
        let g:python3_host_prog = '/usr/local/bin/python3'
    else
        let g:python_host_prog = '/usr/bin/python'
        let g:python3_host_prog = '/usr/bin/python3'
    endif
endif

"ack-vim configuration
"Change default size of copen window in ag from 10 to 7
"let g:ag_qhandler="copen 7"

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"use CtrlP to quickly switch between buffers
nnoremap <b :CtrlPBuffer<cr>

" The dir one means /__pycache__ OR /.git OR /.hg OR /.svn
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](__pycache__|node_modules|target/doc|\.(git|hg|svn)|htmlcov|TAGS|tags)$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ }
" Use regexp search by default
" let g:ctrlp_regexp = 1

" Add <c-o> to AcceptSelection("h") and don't use it for OpenMulti()
let g:ctrlp_prompt_mappings = {
\ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>', '<c-o>'],
\ 'OpenMulti()':          [],
\ }

""Deoplete configuration

if has("macunix")
    if !empty(glob("/Users/rasmus.ansin")) " Valtech laptop
        let g:deoplete#sources#rust#racer_binary='/Users/rasmus.ansin/.cargo/bin/racer'
        let g:deoplete#sources#rust#rust_source_path='/Users/rasmus.ansin/src/rust/src/src'
    else
        let g:deoplete#sources#rust#racer_binary='/Users/ran/.cargo/bin/racer'
        let g:deoplete#sources#rust#rust_source_path='/Users/ran/rust/src/src'
    endif
else
    let g:deoplete#sources#rust#racer_binary='/home/ran/.cargo/bin/racer'
    let g:deoplete#sources#rust#rust_source_path='/home/ran/src/rust/src/src'
endif
let g:deoplete#sources#rust#documentation_max_height=40

""incsearch configuration
"map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

""EasyMotion configuration
"if exists('g:EasyMotion_loaded')
"Without this, bundle/vim-easymotion/plugin/EasyMotion.vim:237 will set
"the easymotion-prefix to <leader><leader>, which is not wanted
map <Leader><Leader><Leader> <Plug>(easymotion-prefix)
map S <Plug>(easymotion-s)
let g:EasyMotion_keys = 'asdghklqwertuiopzxcvbnmfj1234890'
"use smartcase, e.g. case-insensitive search unless search starts with a capital
let g:EasyMotion_smartcase = 1
"'Type Enter or Space key and jump to first match.'
let g:EasyMotion_enter_jump_first = 1
"endif

" fzf.vim configuration
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf

nnoremap <leader>a :Ag<cr>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'


""Gitgutter configuration
"Starts disabled:
let g:gitgutter_enabled = 0
nnoremap <leader>gg :let g:gitgutter_enabled = 1<cr>:GitGutterEnable<cr>
nnoremap <leader>gG :let g:gitgutter_enabled = 0<cr>:GitGutterDisable<cr>
nnoremap <leader>gn :GitGutterEnable<cr>:GitGutter<cr>:GitGutterNextHunk<cr>
nnoremap <leader>gN :GitGutterEnable<cr>:GitGutter<cr>:GitGutterPrevHunk<cr>
"nnoremap <leader>gs :Gstatus<cr>30<c-w>+
nnoremap <leader>gs :GitGutterStageHunk<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit<cr>

""vim-jedi configuration
"let g:jedi#auto_initialization = 0

let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures_delay = 0

" Change this to use Python3 Python 3
" let g:jedi#force_py_version = 3

""LanguageClient-neovim configuration
set rtp+=~/.vim/bundle/LanguageClient-neovim

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }

""lightline configuration
"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ 'active': {
"      \   'left': [ [ 'mode', 'paste' ],
"      \             [ 'filename'],
"      \             [ 'fugitive', 'modified', 'readonly']]
"      \ },
"      \ 'component': {
"      \   'readonly': '%{&filetype=="help"?"":&readonly?"RO":""}',
"      \   'modified': '%{&filetype=="help"?"":&modified?"*":&modifiable?"":"-"}',
"      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
"      \ },
"      \ 'component_visible_condition': {
"      \   'readonly': '(&filetype!="help"&& &readonly)',
"      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
"      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
"      \ },
"      \ 'separator': { 'left': '⮀', 'right': '⮂' },
"      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
"      \ }
"
"      "\ 'separator': { 'left': '', 'right': '' },
"      "\ 'subseparator': { 'left': '|', 'right': '|' }

"vim-mark configuration
highlight MarkWord1 cterm=NONE ctermbg=NONE ctermfg=Yellow guibg=#8CCBEA guifg=Black
highlight MarkWord2 cterm=NONE ctermbg=NONE ctermfg=Green  guibg=#3CCBEA guifg=Black
highlight MarkWord3 cterm=NONE ctermbg=NONE ctermfg=Blue  guibg=#3CCBEA guifg=Black
highlight MarkWord4 cterm=NONE ctermbg=NONE ctermfg=Red  guibg=#3CCBEA guifg=Black

"vim-markdown configuration
let g:markdown_fenced_languages = ['html', 'python', 'haskell', 'javascript', 'bash=sh']
" default markdown_minlines is 50
"let g:markdown_minlines = 100

""netrw configuration
"gx will open file using xdg-open

if has("macunix")
    let g:netrw_browsex_viewer="open"
else
    let g:netrw_browsex_viewer="xdg-open"
    set listchars=tab:>>
endif

""vim-printf configuration

"notational-fzf-vim configuration
if !empty(glob("/home/rasmus/.identifiers/orexplore"))
    let g:nv_directories = ['/Users/ran/orexplore/git/misc-hermod/notes', '/home/rasmus/orexplore/git/misc-hermod/']
else
    let g:nv_directories = ['/home/rasmus/']
endif

" hide banner
"let g:netrw_banner = 0
" hide swp, DS_Store files
let g:netrw_list_hide='.*\.swp$,\.DS_Store,.*\.pyc'
" set tree style listing
let g:netrw_liststyle=3
" display directories first
let g:netrw_sort_sequence='[\/]$'
" ignore case on sorting
let g:netrw_sort_options='i'
" 30% of the screen for the netrw window, 70% for the file window
let g:netrw_winsize = 20
" vsplit netrw to the left window
let g:netrw_altv = 1
" hsplit netrw to the top window
let g:netrw_alto = 1
" open file in a previous buffer (right window)
let g:netrw_browse_split = 4
" preview window is shown in vertically split window
let g:netrw_preview = 1
" buffer setting
let g:netrw_bufsettings = 'nomodifiable nomodified readonly nobuflisted nowrap number'

" not netrw, but gX to open current file in external program

if has("macunix")
    nnoremap <silent> gX :call system('open ' . expand('%'))<CR>
else
    nnoremap <silent> gX :call system('xdg-open ' . expand('%'))<CR>
endif


""ultisnips configuration
" let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
" set rtp+=~/.vim/snippets/
" let g:UltiSnipsSnippetsDir = "~/.vim/snippets/UltiSnips"
" 
" let g:UltiSnipsExpandTrigger="<c-j>"
" let g:UltiSnipsListSnippets="<c-l>"
" 
" "let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" "let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" 
" let g:UltiSnipsEditSplit="vertical"
" nnoremap <leader>eu :UltiSnipsEdit<cr>

""pgsql.vim configuration
let g:sql_type_default = 'pgsql'

""vim-rsi configuration
""alt-d will disable ä so remove the meta-bindings
let g:rsi_no_meta = 1

"" Supertab configuration
"CompletionType = context means that tab will depending on context do e.g.:
"/usr/l<tab>     # will use filename completion
"myvar.t<tab>    # will use user completion if completefunc set,
                "# or omni completion if omnifunc set.
"myvar-><tab>    # same as above
let g:SuperTabDefaultCompletionType = "context"

"" Syntastic configuration {{{
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": ['python', 'elixir'] }

" Use .django.pylintrc to enable Syntastic for Django files
autocmd FileType python
    \ if search('^from django', 'npw') |
    \ let g:syntastic_python_pylint_args="--rcfile=~/.django.pylintrc" |
    \ let g:syntastic_python_pep8_args="--config ~/.config/pep8" |
    \ endif

autocmd FileType python
    \ let g:syntastic_python_checkers=['python3', 'pep8']

autocmd FileType elixir
    \ let g:syntastic_elixir_checkers=['elixir']
let g:syntastic_enable_elixir_checker = 1

"    \ let g:syntastic_python_pylint_args="--rcfile=$XDG_CONFIG_HOME/pylint/django.pylintrc" |

"let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -g -Wall'
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'

nnoremap <leader>c :SyntasticCheck<cr>
nnoremap <leader>C :SyntasticToggle<cr>
""}}}
""vim-vertical-move configuration
let g:vertical_move_default_mapping = 0
nmap <silent> ) <Plug>(vertical_move_down)
nmap <silent> ( <Plug>(vertical_move_up)
xmap <silent> ) <Plug>(vertical_move_down)
xmap <silent> ( <Plug>(vertical_move_up)

" Start pathogen
execute pathogen#infect()

"END OF PLUGIN CONFIGURATION }}}

function! s:AppendCharEOL()
    "echo 'Append Char EOL: '
    let c = nr2char(getchar())
    let v = winsaveview()
    execute 'keepjumps normal! ' . v:count1 . 'A' . c . "\<Esc>"
    call winrestview(v)
endfunction

"nnoremap <silent> R :<C-u>call <SID>AppendCharEOL()<CR>
"}}}
