syntax on
set nocompatible
set laststatus=2

if has('nvim')
    " neovim specific run commands
    colorscheme nord
else
    " standard vim commands
    colorscheme onedark
    if !has('gui_running')
        set t_Co=256
    endif
endif

set noshowmode " as statusbar shows the mode we are in
set nobackup
set number relativenumber

set expandtab	" use spaces instead of tabs
set smarttab
set shiftwidth=4
set tabstop=4

