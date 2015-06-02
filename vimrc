if has("win32")
    cd c:\pyy\
else
    if has("unix")
        let s:uname = system("uname")
	if s:uname == "Darwin\n"
            " Mac options here
	endif
	    " Linux things here
    endif
endif

" :help map-which-keys    " is helpful!
filetype plugin indent on
nnoremap ö /
nnoremap ä /
cnoremap ö /
cnoremap ä /
inoremap jk <esc>
"vnoremap jk <esc>
nnoremap M m
nnoremap :W :w
nnoremap :Qa<CR> :qa<CR>

"_ is used more often than -, so make it easier to use
nnoremap - _
nnoremap _ -

nnoremap <Space> h

nnoremap + <C-a>
nnoremap _ <C-x>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Better copy & paste
"set pastetoggle=<F2>
"set clipboard=unnamed

" Key to insert mode with paste using F2 key
map <F2> :set paste<CR>i
" Leave paste mode on exit
au InsertLeave * set nopaste

"let mapleader = "-"
let mapleader = ","

nmap ä ,

" Quickly edit vimrc
nnoremap <leader>ev :vert split $MYVIMRC<CR>
nnoremap <leader>Ev :split $MYVIMRC<CR>
nnoremap <leader>EV :split $MYVIMRC<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" set bs=2 "Fix backspace. Uncomment this if needed...

set splitbelow
set splitright

set incsearch
set ignorecase
set mouse=a

" highlight trailing spaces in annoying red
"highlight ExtraWhitespace ctermbg=darkmagenta
"match ExtraWhitespace /\s\+$/
"match ExtraWhiteSpace /\S\(\s\+\)$/
"autocmd BufWinEnter * match ExtraWhitespace /\S\(\s\+\)$/
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd BufWinLeave * call clearmatches()
"
" Shortcut to rapidly toggle `set list`
"nmap <leader>l :set list!<CR>:highlight ExtraWhitespace ctermbg=red<CR>:match ExtraWhiteSpace /\S\(\s\+\)$/<CR>
nmap <leader>l :highlight ExtraWhitespace ctermbg=red<CR>:match ExtraWhiteSpace /\S\(\s\+\)$/<CR>
"autocmd CursorMoved * match ExtraWhitespace //
autocmd InsertLeave * match ExtraWhitespace //


" Move top/bottom but leave 4 lines above/below
nnoremap zT zt4<C-y>
nnoremap zB zb4<C-e>
vnoremap zT zt4<C-y>
vnoremap zB zb4<C-e>
inoremap zT <esc>zt4<C-y>i
inoremap zB <esc>zb4<C-e>i

nnoremap o o.<Esc>"_x<Esc>
nnoremap O O.<Esc>"_x<Esc>
"nnoremap <Space> /\n\s*\n<CR>$
"vnoremap <Space> /\n\s*\n<CR>$
nnoremap <leader><Space> k?\n\s*\n<CR>$
vnoremap <leader><Space> k?\n\s*\n<CR>$

" Fix for shift+space
nnoremap ,.<Space> k?\n\s*\n<CR>$
vnoremap ,.<Space> k?\n\s*\n<CR>$
inoremap ,.<Space> <Space>

" Characters to use with ¨ and shift+¨
" ẅëẗÿüï¨ḧ̈́̈́ẍ^f
" âĉêĝĥîĵôŝûŵŷẑ
nnoremap ü i<CR><Esc>k$
nnoremap ë :vert resize 80<CR>

nnoremap :Q :q

" Replace helper: press ,vname/newname<CR> to replace globally
nnoremap <leader>v :%s//gc<Left><Left><Left>

" visual mode replace helper
vnoremap <leader>v :s/\%V/gc<Left><Left><Left>
vnoremap <leader>v :s/\%V/gc<Left><Left><Left>

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

" Jump directly to a spot instead of just to that line
nnoremap ` '
nnoremap ' `
vnoremap ` '
vnoremap ' `

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
nnoremap <leader>q :wincmd W<CR>
nnoremap <leader>r :vert resize 80<CR>
" nnoremap <leader>n :Se<CR>:wincmd r<CR>
" nnoremap <leader>N :Ve<CR>:wincmd r<CR>
nnoremap <leader>n :Se<CR>
nnoremap <leader>N :Ve<CR>:wincmd x<CR>:wincmd w<CR>


set timeoutlen=3500 " used with leader


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
" mkdir -p ~/.vim/colors
" cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
color wombat256mod

syntax enable
" set background=dark
" colorscheme solarized


set t_Co=256

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
nnoremap cib :call New_cisb()<CR>


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


