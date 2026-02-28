set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
let mapleader = ' '
set exrc
set nocompatible              " be iMproved, required
filetype plugin indent on
syntax on

packadd! matchit
if v:version >= 910
  " easy comment :h comment.txt
  packadd! comment
  " auotmatically turn off search hightlight 
endif
if v:version >= 910 || has('nvim-0.11')
  packadd! nohlsearch
endif

set clipboard+=unnamed
set clipboard+=unnamedplus

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent

set ignorecase smartcase
set cursorline
set colorcolumn=80,100,120
set number
set relativenumber

if has('mouse')
    set mouse=nic  " Enable mouse in several mode
    set mousemodel=popup  " Set the behaviour of mouse
endif

set incsearch
set wildmenu

inoremap <silent> jk <Esc>
" Shortcut for faster save and quit
nnoremap <silent> <leader>w :update<CR>
" Saves the file if modified and quit
nnoremap <silent> <leader>q :x<CR>
" Quit all opened buffers
nnoremap <silent> <leader>Q :qa<CR>
nnoremap Y y$
nnoremap <silent> <leader>N <Esc>:let @"=line(".")<CR>

if globpath(&runtimepath, 'colors/habamax.vim') !=# ''
  colorscheme habamax
elseif globpath(&runtimepath, 'colors/sorbet.vim') !=# ''
  colorscheme sorbet
elseif globpath(&runtimepath, 'colors/lunaperche.vim') !=# ''
  colorscheme lunaperche
else
  colorscheme desert;
endif

if exists('g:vscode')
	set rtp+=~/.vim/
endif
call plug#begin("~/.vim/plugged")
	Plug 'tpope/vim-surround'
	Plug  'cohama/lexima.vim'
    Plug 'ludovicchabant/vim-gutentags'
	Plug 'mhinz/vim-grepper'
	if !exists('g:vscode')
		Plug 'pechorin/any-jump.vim'
	endif
call plug#end()

nnoremap <Leader>sG :Grepper<Space>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
nnoremap <leader>tab :tabnew<CR>
