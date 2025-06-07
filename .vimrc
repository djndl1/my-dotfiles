""" Vundle
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
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
"

" Git diff
Plugin 'airblade/vim-gitgutter'

" a status/tabline
Plugin 'vim-airline/vim-airline'
" Linter
Plugin 'dense-analysis/ale'
" lsp support
Plugin 'prabirshrestha/vim-lsp'
" integrate lsp with ALE
Plugin 'rhysd/vim-lsp-ale'
" automatically setup lsp servers
Plugin 'mattn/vim-lsp-settings'
" async completion
Plugin 'prabirshrestha/asyncomplete.vim'
" manage tags file
Plugin 'ludovicchabant/vim-gutentags'
" display tags
Plugin 'preservim/tagbar'
" Orgmode support
Plugin 'jceb/vim-orgmode'
" Markdown support
Plugin 'plasticboy/vim-markdown'

" EditorConfig
Plugin 'editorconfig/editorconfig-vim'

" NERDTree file explorer
Plugin 'preservim/nerdtree'
Plugin 'ryanoasis/vim-devicons'
Plugin 'easymotion/vim-easymotion'

" Language Syntax Support
Plugin 'sheerun/vim-polyglot'

Plugin 'bash-support.vim'
" Assembly
Plugin 'asm8051.vim'
Plugin 'MSIL-Assembly'
Plugin 'philj56/vim-asm-indent'

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
"
"

""" Other customization

:colorscheme oceanic_material
set syntax=on

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat+=%f:%l:%c:%m


