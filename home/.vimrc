" Encoding
set encoding=utf-8

" Set compatibility to Vim only.
set nocompatible

" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

call plug#begin('~/.vim/plugged')
" Use wal color scheme
 Plug 'dylanaraps/wal.vim'

" Install wanted plugins
 Plug 'preservim/nerdtree'
 Plug 'preservim/nerdcommenter'

 Plug 'frazrepo/vim-rainbow'
 Plug 'airblade/vim-gitgutter'
 Plug 'tpope/vim-surround'

 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'

 Plug 'dense-analysis/ale'
 Plug 'itchyny/lightline.vim'
call plug#end()

" Turn on syntax highlighting.
syntax on

" For plug-ins to load correctly.
filetype plugin indent on

" Turn off modelines
set modelines=0

" Automatically wrap text that extends beyond the screen length.
set wrap

" Uncomment below to set the max textwidth. Use a value corresponding to the width of your screen.
" set textwidth=79
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set noshiftround
" set noexpandtab | Stop python from undoing it
autocmd FileType * setlocal noexpandtab

" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5
" Fixes common backspace problems
set backspace=indent,eol,start

" Speed up scrolling in Vim
set ttyfast

" Status bar
set laststatus=0

" Display options
set showmode
set showcmd

" Display different types of white spaces.
" Taken from https://github.com/pr0fdr4c/dots/blob/master/CosyWinterNight/vimrc
set list
set listchars=tab:.\ ,trail:•,extends:#,nbsp:.

" Show line numbers
set number


" Highlight matching search patterns
set hlsearch
" Enable incremental search
set incsearch
" Include matching uppercase words with lowercase search term
set ignorecase
" Include only uppercase words with uppercase search term
set smartcase

" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Load proper colorscheme from wal
colorscheme wal
