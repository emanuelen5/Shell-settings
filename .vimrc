syntax on

set nocompatible " use extended function of vim (not compatible with vi)
set backup " take backup. if not, specify [ set nobackup ]
set backupdir=~/.bak  " specify backup directory
" set hlsearch " Highlight all matches in search
set incsearch " use incremental search

set tabstop=4 softtabstop=4 noexpandtab shiftwidth=4 autoindent smartindent smarttab " Use tabs as indentation
set mouse=a " Mouse input
set number " Line numbers
" cd window to directory of open file. Taken from https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
autocmd BufEnter * silent! lcd %:p:h

" Disable bell and window flashing (to remove hang when scrolling outside of
" window)
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Use indent for folding, but do not fold at start
set foldmethod=indent
au BufReadPost * normal zR

"" File types
au BufRead,BufNewFile *.ts setfiletype typescript
au Filetype makefile source ~/.vim/makefile.vim

" Lightline
set laststatus=2

" Install all vim-plug plugins
" https://medium.com/@huntie/10-essential-vim-plugins-for-2018-39957190b7a9
call plug#begin('~/.vim/plugged')
	Plug 'junegunn/fzf' " Fuzzy search files
	Plug 'junegunn/fzf.vim'
	Plug 'itchyny/lightline.vim' " A new status line
	Plug 'terryma/vim-multiple-cursors' " Selecting multiple regions at once
	Plug 'tpope/vim-eunuch' " File creation commands
	Plug 'scrooloose/nerdtree' " See the file tree
	Plug 'editorconfig/editorconfig-vim' " Local configuration files per project
	Plug 'w0rp/ale' " Asynchronous Lint Engine
	Plug 'airblade/vim-gitgutter' " Git status in the gutter
call plug#end()
