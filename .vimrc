syntax on

set nocompatible " use extended function of vim (not compatible with vi)
set backup " take backup. if not, specify [ set nobackup ]
set backupdir=~/.backup  " specify backup directory
set hlsearch " Highlight all matches in search
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



"""""""""""""""""
"" VUNDLE
"""""""""""""""""
	set nocompatible              " be iMproved, required
	filetype off                  " required

	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')

	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'

	" The following are examples of different formats supported.
	" Keep Plugin commands between vundle#begin/end.
	" plugin on GitHub repo
	Plugin 'tpope/vim-fugitive'
	" plugin from http://vim-scripts.org/vim/scripts.html
	" Plugin 'L9'
	" Git plugin not hosted on GitHub
	Plugin 'git://git.wincent.com/command-t.git'
	" git repos on your local machine (i.e. when working on your own plugin)
	Plugin 'file:///home/gmarik/path/to/plugin'
	" The sparkup vim script is in a subdirectory of this repo called vim.
	" Pass the path to set the runtimepath properly.
	Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
	Plugin 'leafgarland/typescript-vim'
	" Install L9 and avoid a Naming conflict if you've already installed a
	" different version somewhere else.
	" Plugin 'ascenator/L9', {'name': 'newL9'}

	" All of your Plugins must be added before the following line
	call vundle#end()            " required
	filetype plugin indent on    " required
	" To ignore plugin indent changes, instead use:
	"filetype plugin on
	"
	" Brief help
	" :PluginList       - lists configured plugins
	" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
	" :PluginSearch foo - searches for foo; append `!` to refresh local cache
	" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
	"
	" see :h vundle for more details or wiki for FAQ
	" Put your non-Plugin stuff after this line
