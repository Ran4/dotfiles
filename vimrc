" :help map-which-keys    " is helpful!
filetype plugin indent on 
nnoremap ö /
nnoremap ä /
cnoremap ö /
cnoremap ä /
imap kl <esc>
vmap kl <esc>
nnoremap :W :w
nnoremap :Qa<CR> :qa<CR>

" Better copy & paste
set pastetoggle=<F2>
set clipboard=unnamed

"let mapleader = "-"
let mapleader = ","
nnoremap <Leader>ev :split $MYVIMRC<CR>
" set bs=2 "Fix backspace. Uncomment this if needed...

set incsearch
set ignorecase
set mouse=a

nnoremap o o.<Esc>"_x<Esc>
nnoremap O O.<Esc>"_x<Esc>
nnoremap <Space> /\n\s*\n<CR>$
vnoremap <Space> /\n\s*\n<CR>$
nnoremap <leader>Space> k?\n\s*\n<CR>$
vnoremap <leader><Space> k?\n\s*\n<CR>$

" Fix for shift+space
nnoremap ,.<Space> k?\n\s*\n<CR>$
vnoremap ,.<Space> k?\n\s*\n<CR>$
inoremap ,.<Space> <Space>

inoremap <C-h> b
inoremap <C-l> w

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
nnoremap ," viw<ESC>a"<ESC>hbi"<ESC>lelbb
nnoremap ,' viw<ESC>a'<ESC>hbi'<ESC>lelbb
nnoremap ,[ viw<ESC>a]<ESC>hbi[<ESC>lelbb
nnoremap ,] viw<ESC>a]<ESC>hbi[<ESC>lelbb
vnoremap ," <ESC>`>a"<ESC>`<i"<ESC>
vnoremap ,' <ESC>`>a'<ESC>`<i'<ESC>

" Jump directly to a spot instead of just to that line
nnoremap ` '
nnoremap ' `
vnoremap ` '
vnoremap ' `

" Easier indentation
vnoremap < <gv
vnoremap > >gv

nnoremap <leader>d /def <CR>zz
vnoremap <leader>d /def <CR>zz
nnoremap <leader>D ?def <CR>zz
vnoremap <leader>D ?def <CR>zz
nnoremap <leader>c /class <CR>zz
nnoremap <leader>C ?class <CR>zz
nnoremap <leader>w :wincmd w<CR>
nnoremap <leader>W :wincmd W<CR>
nnoremap <leader>q :wincmd W<CR>
nnoremap <leader>r :vert resize 80<CR>
nnoremap <leader>n :Se<CR>:wincmd r<CR>
nnoremap <leader>N :Ve<CR>:wincmd r<CR>

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

" syntax enable
" set background=dark
" colorscheme solarized


set t_Co=256

" Change in brackets function, since ci( initially doesn't work
function New_cib()
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

nnoremap ci( :call New_cib()<CR>
nnoremap cib :call New_cib()<CR>
