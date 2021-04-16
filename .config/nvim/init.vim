" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝

" https://github.com/b4skyx/dotfiles

let mapleader =","
let maplocalleader = "\\"


" Vim-Plug init
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

" Vim-Plug Plugins -- should be seperate from nvim's inbuilt plugins directory
call plug#begin('~/.config/nvim/plugged')
" https://github.com/junegunn/vim-plug - Examples for help on how to install plugins

Plug 'preservim/nerdtree'


call plug#end()

" include aspects of standard vimrc
source ~/.vimrc

" Clipboard
	set go=a
	set clipboard+=unnamedplus

" Clipboard Remap
	vnoremap  <leader>y  "+y
	nnoremap  <leader>Y  "+yg_
	nnoremap  <leader>y  "+y
	nnoremap  <leader>yy  "+yy
	nnoremap <leader>p "+p
	nnoremap <leader>P "+P
	vnoremap <leader>p "+p
	vnoremap <leader>P "+P

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Split Navigation shortcuts
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Keep selection after shift
	vnoremap < <gv
	vnoremap > >gv

" NERDTree start when nvim is opened
    autocmd VimEnter * NERDTree

" NERDTree keybinds
    nnoremap <leader>n :NERDTreeFocus<CR>
    nnoremap <C-n> :NERDTree<CR>
    nnoremap <C-t> :NERDTreeToggle<CR>
    nnoremap <C-f> :NERDTreeFind<CR>

augroup RELOAD
	autocmd!
	" Close vim when Nerdtree is last window
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

	" Disables automatic commenting on newline:
	" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

	" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e
augroup END


" Sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
