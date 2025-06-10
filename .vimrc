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
" colorschemes
Plugin 'glepnir/oceanic-material'
Plugin 'altercation/vim-colors-solarized'
Plugin 'sickill/vim-monokai'
Plugin 'arcticicestudio/nord-vim'
Plugin 'joshdick/onedark.vim'
"
Plugin 'tpope/vim-surround'
Plugin 'cohama/lexima.vim'

"
"
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" Git diff
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-speeddating'

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
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
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
Plugin 'Xuyuanp/nerdtree-git-plugin'

Plugin 'ryanoasis/vim-devicons'
Plugin 'easymotion/vim-easymotion'

" Language Syntax Support
Plugin 'sheerun/vim-polyglot'

Plugin 'bash-support.vim'
" Assembly
Plugin 'asm8051.vim'
Plugin 'MSIL-Assembly'
Plugin 'philj56/vim-asm-indent'

" async linting and make framework
Plugin 'neomake/neomake'

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
" map NERDTree
map <C-n> :NERDTreeToggle<CR>

" register LSP server
if (executable('ccls'))
	au user lsp_setup call lsp#register_server({
		\ 'name': 'ccls',
		\	'cmd': { server_info -> ['ccls']},
		\	'allowlist': ['c']
		\ })
endif

" set up vim-lsp keys
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" set up asynccomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" GDB
packadd termdebug


""" Other customization
colorscheme onedark
set syntax=on
set number

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat+=%f:%l:%c:%m


set guifont=Cascadia_Mono:h11
set clipboard=unnamedplus
