"{{{ MAPPINGS
let mapleader = "ä"
nmap , ä
nmap ö ä
nnoremap ,, ,

"Buffer shortcuts: open new, next, prev, delete
nnoremap <b :b <c-d>
nnoremap <l :lnext<cr>
nnoremap <L :lprevious<cr>
"nnoremap <n :bn<cr>
"nnoremap <p :bp<cr>
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
nnoremap <bs> <nop>

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

" Substitution  helper: press <leader>vname/newname<CR> to replace globally
nnoremap <leader>s :%s//gc<Left><Left><Left>
" visual mode replace helper
vnoremap <leader>s :s/\%V/g<Left><Left>
vnoremap <leader>s :s//g<Left><Left>

"Move around to next window and resizing it
nnoremap <leader>w :wincmd w<CR>
nnoremap <leader>W :wincmd W<CR>
nnoremap <leader>r :vert resize 80<CR>

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
augroup FastEscape
au InsertEnter * set timeoutlen=450
au InsertLeave * set timeoutlen=2500
augroup END

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
inoremap zT <esc>zt4<C-y>i
inoremap zB <esc>zb4<C-e>i

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

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
"set ignorecase "ignore case when searching
set smartcase "ignore case when searching, except if we start with a capital
if has("gui_running")
    set mouse=a "use mouse in all modes
    set guioptions-=T "removes toolbar
    set guioptions-=m "removes menu
    set guioptions-=l "removes always-on left-hand scrollbar
    set guioptions-=r "removes always-on right-hand scrollbar
    set guifont=Terminus\ 10
    nnoremap <leader><leader>1 :set guifont=Terminus\ 9<cr>
    nnoremap <leader><leader>2 :set guifont=Terminus\ 10<cr>
    nnoremap <leader><leader>3 :set guifont=Terminus\ 11<cr>
    nnoremap <leader><leader>4 :set guifont=Terminus\ 13<cr>
    nnoremap <leader><leader>5 :set guifont=Terminus\ 14<cr>
    nnoremap <leader><leader>6 :set guifont=Terminus\ 16<cr>
else
    set mouse=n "only use mouse in visual mode
endif

"Prevent auto-comments
"c: Auto-wrap comments using textwidth, autoinserting the current comment leader
"r: Autoinsert the current comment leader after hitting <CR> in Insert mode.
"o: Autoinsert the current comment leader after hitting o/O in Normal mode.
autocmd BufNewFile,BufWinEnter * setlocal formatoptions-=cro
"set formatoptions-=cro "this won't work, will be owerwritten, see this link:
"http://stackoverflow.com/questions/6076592/vim-set-formatoptions-being-lost

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
" Color scheme
" mkdir -p ~/.vim/colors
" cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
color wombat256mod
"color wintersday

syntax enable
" set background=dark
" colorscheme solarized

set t_Co=256

" highlight trailing spaces
" Shortcut to rapidly toggle `set list`
nmap <leader>l :highlight ExtraWhitespace ctermbg=red<CR>:match ExtraWhiteSpace /\S\(\s\+\)$/<CR>
"highlight current line in insert mode, also don't match extrawhitespace until
"after leaving insertmode
autocmd InsertEnter * set cursorline! | match ExtraWhitespace //
autocmd InsertLeave * set cursorline! | call HighlightExtraWhitespace()


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
nnoremap cip :call New_cip()<CR>

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
    augroup bashalias
        autocmd BufRead,BufNewFile .bash_aliases,bash_aliases set filetype=sh
    augroup END

    autocmd BufRead,BufNewFile * call HighlightExtraWhitespace()
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

""helper plugin that enables repetition with dot in plugins such as vim-surround
"git clone git://github.com/tpope/vim-repeat.git ~/.vim/bundle/vim-repeat

""supertab, adds <Tab> for tab completion
"!git clone git://github.com/ervandew/supertab ~/.vim/bundle/supertab

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

"use CtrlP to quickly switch between buffers
nnoremap <b :CtrlPBuffer<cr>

nnoremap S s
"if exists('g:EasyMotion_loaded')
map s <Plug>(easymotion-s)
map / <Plug>(easymotion-sn)
"map ? <Plug>(easymotion-tn)
"map ö <Plug>(easymotion-sn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
"map <cr> <Plug>(easymotion-w)
" default except ; key which is hard to type
"let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'
let g:EasyMotion_keys = 'asdghklqwertuiopzxcvbnmfj1234890'
"use smartcase, e.g. case-insensitive search unless search starts with a capital
let g:EasyMotion_smartcase = 1
"'Type Enter or Space key and jump to first match.'
let g:EasyMotion_enter_jump_first = 1
"endif

" syntastic, for syntax higlighting
" GIT CLONE LINK GOES HERE?
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -g -Wall'
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'

" Start pathogen
execute pathogen#infect()

" Add fzf to RunTimePath
set rtp+=~/.fzf
nnoremap <leader>f :FZF<cr>

function! s:AppendCharEOL()
    "echo 'Append Char EOL: '
    let c = nr2char(getchar())
    let v = winsaveview()
    execute 'keepjumps normal! ' . v:count1 . 'A' . c . "\<Esc>"
    call winrestview(v)
endfunction

nnoremap <silent> R :<C-u>call <SID>AppendCharEOL()<CR>
"}}}
