
"{{{ MAPPINGS
let mapleader = "ä"
nmap , ä
"nmap ö ä
nnoremap ,, ,

nmap cså cs[
nmap cs¨ cs]

omap iå i[
omap i¨ i]
omap aå a[
omap a¨ a]

nmap å [
nmap ¨ ]

"Helper for spell check: press <tab> on a word, <esc> to choose word
nmap <s-tab> viw<esc>a<c-x>s<tab>
nnoremap sus :set spell spelllang=en_us<cr>
nnoremap sgb :set spell spelllang=en_gb<cr>

"buffer splitting
nnoremap sbn :sbn<cr>
nnoremap sbv :vert sbn<cr>

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

nnoremap <space> :w<CR>
" press <backspace> to switch to the "alternate file"
nnoremap <bs> <C-^>

" Append to in-commands
nnoremap <leader>a" f";i
nnoremap <leader>a' f';i
nnoremap <leader>a) f)i

" Quickly edit vimrc
nnoremap <leader>ev :vert split $MYVIMRC<CR>
nnoremap <leader>Ev :split $MYVIMRC<CR>
nnoremap <leader>EV :split $MYVIMRC<CR>
"yank current line and enter it into command mode without pressing enter
nnoremap <leader>: "xy:<c-r>x<bs>

nnoremap <leader>ei :vert split ~/.i3/config<CR>

nnoremap <leader><leader>n :set number!<CR>

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

"Resize window
nnoremap <leader>r :vert resize 84<CR>
nnoremap <leader>R :vert resize 80<CR>
nnoremap <silent> <Leader><Leader>+ :exe "resize " . (winheight(0) * 3/2)<cr>
nnoremap <silent> <Leader><Leader>- :exe "resize " . (winheight(0) * 2/3)<cr>
nnoremap <silent> <Leader>+ :exe "vert resize " . (winwidth(0) * 3/2)<cr>
nnoremap <silent> <Leader>- :exe "vert resize " . (winwidth(0) * 2/3)<cr>

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
cnoremap <c-a> <home>

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


nnoremap + <C-a>
nnoremap - <C-x>

"0 is much easier to reach than ^ on many non-US layouts
nnoremap 0 ^
nnoremap ´ ^
nnoremap ^ 0
nnoremap d0 d^
nnoremap y0 y^

" More reasonable use of Y (as opposed to being identical to yy)
nnoremap Y y$

" Jump directly to a spot instead of just to that line
nnoremap ` '
nnoremap ' `
vnoremap ` '
vnoremap ' `

" Quickly replay a record
"nnoremap Q @q

"Quickly move between windows with ctrl+hjkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" o and O doesn't go into insert mode
nnoremap o o.<Esc>"_x<Esc>
nnoremap O O.<Esc>"_x<Esc>

" Characters to use with ¨ and shift+¨
" ẅëẗÿüï¨ḧ̈́̈́ẍ^f
" âĉêĝĥîĵôŝûŵŷẑ
nnoremap ü i<CR><Esc>k$
nnoremap ë :vert resize 80<CR>
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

" Call C/C++, assuming that there is an outfile with the output name %:r.out
nnoremap <f5> :!clear && make && echo "    //// Output ////" && ./%:r.out<cr>
map <F8> :setlocal spell! spelllang=en_gb<CR>

" Inverse of join (J)
function! BreakHere()
    s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
    call histdel("/", -1)
endfunction
nnoremap K :call BreakHere()<CR>

" Easier indentation in visual mode
vnoremap < <gv
vnoremap > >gv

" nnoremap <leader>d [mzz
" vnoremap <leader>d ]mzz
" nnoremap <leader>D ]mzz
" vnoremap <leader>D ]mzz
" nnoremap <leader>c /class <CR>zz
" nnoremap <leader>c /class <CR>zz
" nnoremap <leader>C ?class <CR>zz
"}}}
"{{{ SET OPTIONS
filetype plugin indent on

set number "show line numbers
"set relativenumber

set shiftwidth=4
set softtabstop=4 "Number of spaces in tab when editing

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
set expandtab "Expands tabs into spaces

highlight SpellBad ctermbg=5

"set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize

" set bs=2 "Fix backspace. Uncomment this if needed...

set foldmethod=marker

set splitbelow
set splitright

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
    "set guifont=ProggySquareTT\ 12
    "set guifont=ProggyTinyTT\ 12
    "set guifont=Monospace\ 11
    set guifont=Monospace\ Regular\ 10
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
    inoremap <s-cr> <esc>ZZ
else
    set mouse=n "only use mouse in visual mode
endif

set timeout
set timeoutlen=2500 " used with e.g. leader
set ttimeoutlen=10

set wildmode=longest,list,full

set history=1000

set laststatus=2 "always show statusbar. 1 means 'only when 2+ windows open'

"always keep at a few lines at the top/bottom shown when moving around
set scrolloff=4

"Disable Bram's start message
set shortmess+=I
"}}}
"{{{ COLORS AND HIGHLIGHTING

set t_Co=256

" Color scheme
" mkdir -p ~/.vim/colors
" cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
color wombat256mod
"color lilypink
"color wintersday

syntax enable
" set background=dark
" colorscheme solarized

" highlight trailing spaces
" Shortcut to rapidly toggle `set list`
nmap <leader>l :highlight ExtraWhitespace ctermbg=red<CR>:match ExtraWhiteSpace /\S\(\s\+\)$/<CR>
"highlight current line in insert mode, also don't match extrawhitespace until
"after leaving insertmode
if has("autocmd")
    augroup whitespace
        autocmd!
        autocmd InsertEnter * set cursorline! | match ExtraWhitespace //
        autocmd InsertLeave * set cursorline! | call HighlightExtraWhitespace()
    augroup END
endif


function HighlightExtraWhitespace()
    "highlight ExtraWhitespace ctermbg=red
    "6 is a blue color?
    highlight ExtraWhitespace ctermbg=6
    match ExtraWhiteSpace /\S\(\s\+\)$/
endfunction

if exists('+colorcolumn')
    set colorcolumn=110
    " Colorcolumn color is very dark grey
    highlight colorcolumn ctermbg=0 guibg=black

    "au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"highlight Search term=none ctermfg=0 ctermbg=180
highlight Search ctermfg=0 ctermbg=180
"}}}
"{{{ FUNCTIONS
" Change in paranthesis function, since ci( initially doesn't work
function New_cip()
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
function New_cisb()
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
function New_cisqb()
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
nnoremap ci} :call New_cisqb()<CR>
nnoremap cis :call New_cisqb()<CR>

if has("autocmd")
    augroup bufstuff
        autocmd!
        autocmd BufRead,BufNewFile .bash_aliases,bash_aliases set filetype=sh
        autocmd BufRead,BufNewFile *.arff set filetype=arff
        
        autocmd BufRead,BufNewFile * call HighlightExtraWhitespace()
        
        "Prevent auto-comments
        "c: Auto-wrap comments using textwidth, autoinserting the current comment leader
        "r: Autoinsert the current comment leader after hitting <CR> in Insert mode.
        "o: Autoinsert the current comment leader after hitting o/O in Normal mode.
        autocmd BufNewFile,BufWinEnter * setlocal formatoptions-=cro
        "set formatoptions-=cro "this won't work, will be owerwritten, see this link:
        "http://stackoverflow.com/questions/6076592/vim-set-formatoptions-being-lost
        
    augroup END
endif

"}}}
"{{{ PLUGINS
"cd ~/.vim/bundle

"Ack plugin for vim, usagE: :Ack [options] {pattern} [{directories}]
"!git clone https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack.vim
"Change default size of copen window in ag from 10 to 7
"let g:ag_qhandler="copen 7"

""Ag plugin for vim, usagE: :Ag [options] {pattern} [{directories}]
"!git clone https://github.com/rking/ag.vim ~/.vim/bundle/ag.vim

""vim airline is a lightweight alternative to powerline, written in pure ViML
"!git clone https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline

"""braceless adds text objects, folding and more for many braceless languages such as Python
"!git clone https://github.com/tweekmonster/braceless.vim ~/.vim/bundle/braceless

""Clever-f allows f/F to be pressed to repeat previous f/F search
"!git clone https://github.com/rhysd/clever-f.vim

""{{{ Clojure plugins
"""Clojure runtime files, extracted from the VimClojure project, required for vim-clojure-highlight
""!git clone https://github.com/guns/vim-clojure-static ~/.vim/bundle/vim-clojure-highlight

"""Quasi-REPL for clojure
""!git clone https://github.com/tpope/vim-fireplace ~/.vim/bundle/vim-fireplace

""vim-clojure-highlight gives extended syntax highlightinging for clojure
""!git clone https://github.com/guns/vim-clojure-highlight ~/.vim/bundle/vim-clojure-highlight
""}}}

"""ctrl-p is a fuzzy file finder
"!git clone https://github.com/kien/ctrlp.vim ~/.vim/bundle/ctrlp.vim

"""vim-gitgutter shows a git diff in the 'gutter' (sign column)
"!git clone git://github.com/airblade/vim-gitgutter.git ~/.vim/bundle/vim-gitgutter

"""incsearch incrementally highlights all pattern being matched.
"!git clone https://github.com/haya14busa/incsearch.vim ~/.vim/bundle/incsearch.vim

"""jedi-vim is a vim-binding to the autocompletion library Jedi
"!git clone --recursive https://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim

""helper plugin that enables repetition with dot in plugins such as vim-surround
"git clone git://github.com/tpope/vim-repeat.git ~/.vim/bundle/vim-repeat

"vim-rsi, adds 'readline-style-insertions' to command and insert mode
"!git clone https://github.com/tpope/vim-rsi.git ~/.vim/bundle/vim-rsi

""supertab, adds <Tab> for tab completion
"!git clone git://github.com/ervandew/supertab ~/.vim/bundle/supertab

""vim-vertical move, adds a vertical move motion to move without changing the cursor column
"!git clone git://github.com/bruno-/vim-vertical-move.git ~/.vim/bundle/vim-vertical-move

""vim-visual-star-search, allows * operator on visual words (and <leader>* to vimgrep)
"!git clone https://github.com/bronson/vim-visual-star-search ~/.vim/bundle/vim-visual-star-search

""targets.vim allows movements like cin" (change in next ") and da,
"git clone git://github.com/wellle/targets.vim.git ~/.vim/bundle/targets.vim

""vim-tmux-navigator allows seamless navigation between vim and tmux splits
"!git clone https://github.com/christoomey/vim-tmux-navigator ~/.vim/bundle/vim-tmux-navigator

"!git clone https://github.com/easymotion/vim-easymotion ~/.vim/bundle/vim-easymotion

""vim-exchange: add the cx operator. I.e. cxe on one word, then cxe to exchange
"!git clone git://github.com/tommcdo/vim-exchange.git

""vim-fugitive is a git plugin
"!git clone git://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive

""use e.g. ds( to delete surrounding (

"!git clone git://github.com/tpope/vim-surround.git

""vim-tbone allows tmux commands
"!git clone git://github.com/tpope/vim-tbone.git

"!git clone https://github.com/bronson/vim-trailing-whitespace ~/.vim/bundle/vim-trailing-whitespace
"Rebuild help tags (comes with pathogen): should be done after any new install (?)
":Helptags

"PLUGIN CONFIGURATION {{{
""vim-airline configuration
"Don't show trailing spaces in Airline
"let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long' ]
"let g:airline#extensions#whitespace#checks = ['indent', 'long']
let g:airline#extensions#whitespace#enabled = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#syntastic#enabled = 0

let g:airline_theme = 'badwolf'

""Braceless configuration
autocmd FileType python BracelessEnable
"Change default block key to p from P: paragraph is useless in Python code
let g:braceless_block_key = 'p'
"+indent 	Enable indent handling
"+fold 	        Enable folding
"+fold-inner 	Enable folding, but fold on the inner block
"+highlight 	Enable indent guide
"+highlight-cc 	Enable indent guide, but use colorcolumn
"+highlight-cc2 Enable indent guide and use colorcolumn

"use CtrlP to quickly switch between buffers
nnoremap <b :CtrlPBuffer<cr>

""incsearch configuration
map /  <Plug>(incsearch-forward)
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
nnoremap S s
"if exists('g:EasyMotion_loaded')
map s <Plug>(easymotion-s)
"map / <Plug>(easymotion-sn)
"map ? <Plug>(easymotion-tn)
"map ö <Plug>(easymotion-sn)
"map n <Plug>(easymotion-next)
"map N <Plug>(easymotion-prev)
"map <cr> <Plug>(easymotion-w)
" default except ; key which is hard to type
"let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'
let g:EasyMotion_keys = 'asdghklqwertuiopzxcvbnmfj1234890'
"use smartcase, e.g. case-insensitive search unless search starts with a capital
let g:EasyMotion_smartcase = 1
"'Type Enter or Space key and jump to first match.'
let g:EasyMotion_enter_jump_first = 1
"endif

""Gitgutter configuration
"Starts disabled:
let g:gitgutter_enabled = 0
nnoremap <leader>gg :let g:gitgutter_enabled = 1<cr>:GitGutterEnable<cr>

""vim-jedi configuration
"let g:jedi#auto_initialization = 0

let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures_delay = 0

""vim-rsi configuration
""alt-d will disable ä so remove the meta-bindings
let g:rsi_no_meta = 1

" syntastic, for syntax higlighting
" GIT CLONE LINK GOES HERE?
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -g -Wall'
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'

""vim-vertical-move configuration
let g:vertical_move_default_mapping = 0
nmap <silent> ) <Plug>(vertical_move_down)
nmap <silent> ( <Plug>(vertical_move_up)
xmap <silent> ) <Plug>(vertical_move_down)
xmap <silent> ( <Plug>(vertical_move_up)

" Start pathogen
execute pathogen#infect()

" Add fzf to RunTimePath
set rtp+=~/.fzf
nnoremap <leader>f :FZF<cr>
"END OF PLUGIN CONFIGURATION }}}

function! s:AppendCharEOL()
    "echo 'Append Char EOL: '
    let c = nr2char(getchar())
    let v = winsaveview()
    execute 'keepjumps normal! ' . v:count1 . 'A' . c . "\<Esc>"
    call winrestview(v)
endfunction

nnoremap <silent> R :<C-u>call <SID>AppendCharEOL()<CR>
"}}}
