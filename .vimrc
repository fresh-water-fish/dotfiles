syntax on
set nocompatible
set laststatus=2

set noshowmode " as statusbar shows the mode we are in
set nobackup
set number relativenumber

set expandtab	" use spaces instead of tabs
set smarttab
set shiftwidth=4
set tabstop=4
if has('nvim')
    " neovim specific run commands
    colorscheme nord
else
    " standard vim commands
    if !has('gui_running')
        set t_Co=256
    endif

    if ! filereadable(expand('~/.vim/autoload/plug.vim'))
        echo "Downloading junegunn/vim-plug to manage plugins..."
        silent !mkdir -p ~/.vim/autoload/
        silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.vim/autoload/plug.vim
    endif

    call plug#begin('~/.vim/autoload/plugged')
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'arcticicestudio/nord-vim'
    call plug#end()

    colorscheme nord

endif
