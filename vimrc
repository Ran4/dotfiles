" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" set bs=2 "Fix backspace. Uncomment this if needed...

set splitbelow
set splitright

set incsearch
set ignorecase
if has("gui_running")
    set mouse=a
else
    set mouse=n
endif

set timeout
set timeoutlen=2500 " used with e.g. leader
set ttimeoutlen=10

"Don't auto-add comments after typing <CR> in insert mode
set formatoptions-=r

"Don't wait as long in insert mode (to enable us to quickly type j and k)
augroup FastEscape
    au InsertEnter * set timeoutlen=450
    au InsertLeave * set timeoutlen=2500
augroup END

filetype plugin indent on

" :help map-which-keys    " is helpful!
nnoremap ö /
nnoremap dö d/
cnoremap ö /
vnoremap ö /
imap jk <esc>

"Fix accidentally holding shift while trying to quite vim
command Q q
command Qa qa
command QA qa

"let mapleader = "-"
let mapleader = ","
nnoremap ,, ,

nmap ä ,
"noremap <space> i<space><esc>l
"
"jump backward in jumplist, inverse of tab
nnoremap <bs> <c-o>

"_ is used more often than -, so make it easier to use
nnoremap - _
nnoremap _ -

nnoremap + <C-a>
nnoremap _ <C-x>

" More reasonable use of Y
nnoremap Y y$

" Jump directly to a spot instead of just to that line
nnoremap ` '
nnoremap ' `
vnoremap ` '
vnoremap ' `

" Quick record
nnoremap Q qq
nnoremap <leader>q @q

"set clipboard=unnamed
" Key to insert mode with paste using F2 key
map <F2> :set paste<CR>i
" Leave paste mode on exit
au InsertLeave * set nopaste

"Quickly move between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap o o.<Esc>"_x<Esc>
nnoremap O O.<Esc>"_x<Esc>

" Move to the last character before a newline
"nnoremap <Space> /\n\s*\n<CR>$
nnoremap <Space> :w<cr>
"vnoremap <Space> /\n\s*\n<CR>$
nnoremap <leader><Space> k?\n\s*\n<CR>$
vnoremap <leader><Space> k?\n\s*\n<CR>$
" This only works in gvim... use the <leader><space> above in the terminal
nnoremap <S-Space> k?\n\s*\n<CR>$
vnoremap <S-Space> k?\n\s*\n<CR>$

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

" Substitution  helper: press <leader>vname/newname<CR> to replace globally
nnoremap <leader>v :%s//gc<Left><Left><Left>
" visual mode replace helper
vnoremap <leader>v :s/\%V/g<Left><Left>

" Call python
nnoremap <leader>p :!clear && python %<CR>
nnoremap <leader>i :!clear && python -i %<CR>

" Call C/C++, assuming that there is an outfile with the output name %:r.out
nnoremap <f5> :!clear && make && echo "    //// Output ////" && ./%:r.out<cr>

" Prepends # to line and goes down, Q removes then
nnoremap <Leader>q I#<esc>j
nnoremap <Leader>Q kx

" q in visual mode appends '#~ ' to marked lines, Q removes them
vnoremap q 0<C-v>I#~ <ESC>
vnoremap Q 0<C-v>x..<ESC>

" Adds characters around word
nnoremap <Leader>" viw<ESC>a"<ESC>hbi"<ESC>lel
nnoremap <Leader>' viw<ESC>a'<ESC>hbi'<ESC>lel
vnoremap <Leader>" <ESC>`>a"<ESC>`<i"<ESC>
vnoremap <Leader>' <ESC>`>a'<ESC>`<i'<ESC>
nnoremap <Leader>[ viw<ESC>a]<ESC>hbi[<ESC>%
nnoremap <Leader>] viw<ESC>a]<ESC>hbi[<ESC>%

" Append to in-commands
nnoremap <Leader>a" f";i
nnoremap <Leader>a' f';i
nnoremap <Leader>a) f)i

" Quickly edit vimrc
nnoremap <leader>ev :vert split $MYVIMRC<CR>
nnoremap <leader>Ev :split $MYVIMRC<CR>
nnoremap <leader>EV :split $MYVIMRC<CR>

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
nnoremap <leader>w :wincmd w<CR>
nnoremap <leader>W :wincmd W<CR>
"nnoremap <leader>q :wincmd W<CR>
nnoremap <leader>r :vert resize 80<CR>
nnoremap <leader>n :set number!<CR>



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
autocmd InsertEnter * set cul! | match ExtraWhitespace //
"autocmd InsertEnter * set cul!
autocmd InsertLeave * set cul! | call HighlightExtraWhitespace()

function HighlightExtraWhitespace()
    "highlight ExtraWhitespace ctermbg=red
    "6 is a blue color?
    highlight ExtraWhitespace ctermbg=6
    match ExtraWhiteSpace /\S\(\s\+\)$/
endfunction

if exists('+colorcolumn')
    set colorcolumn=81
    " Colorcolumn color is very dark grey
    highlight colorcolumn ctermbg=0 guibg=black
    
    "au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

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


" Download NERDTree
"cd ~/.vim/bundle
"!git clone https://github.com/scrooloose/nerdtree.git

" Download vim-exchange in order to get the cx operator
"cd ~/.vim/bundle
"!git clone git://github.com/tommcdo/vim-exchange.git

"cd ~/.vim/bundle
"!git clone git://github.com/tpope/vim-surround.git

" Download vim-tbone, allowing tmux commands
"cd ~/.vim/bundle
"!git clone git://github.com/tpope/vim-tbone.git

" targets.vim, allows movements like cin" (change in next ") and da,
"git clone git://github.com/wellle/targets.vim.git ~/.vim/bundle/targets.vim

" syntastic, for syntax higlighting
" GIT CLONE LINK GOES HERE?
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -g -Wall'

" Start pathogen
execute pathogen#infect()

" For NERDTree
"nnoremap § :NERDTree<CR>
"nnoremap <TAB> :NERDTree<CR>

" Add fzf to RunTimePath
set rtp+=~/.fzf
