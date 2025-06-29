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
" deal with surroundings like quotes, parentheses, HTML tags
Plugin 'tpope/vim-surround'
" input surroundings
Plugin  'cohama/lexima.vim'

" automatically save the current buffer
Plugin '907th/vim-auto-save'

"
" file/text search
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mhinz/vim-grepper'
"
"" Git diff
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-speeddating'
"
"" a status/tabline
Plugin 'vim-airline/vim-airline'
"" Linter
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
" Snippet Support
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'

Plugin 'bash-support.vim'
" Assembly
Plugin 'asm8051.vim'
Plugin 'MSIL-Assembly'
Plugin 'philj56/vim-asm-indent'

" async linting and make framework
Plugin 'neomake/neomake'

Plugin 'https://gitlab.com/HiPhish/info.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " three options on, required
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

""" Enable builtin packages
" more features of %
packadd! matchit
" easy comment :h comment.txt
packadd! comment
" auotmatically turn off search hightlight 
packadd! nohlsearch
""" 

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

" FZF mapping

command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number -- '.fzf#shellescape(<q-args>),
      \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" search for files
nnoremap <Space><Space> :Files<CR>
" search for lines
nnoremap <Space>ss :BLines<CR>
" ripgrep in the current directory
nnoremap <Space>sp :Rg<CR>
" git ls-files
nnoremap <Space>g<Space> :GFiles<CR>
" search for tags in the current directory
nnoremap <Space>tp :Tags<CR>
" git grep
nnoremap <Space>sg :GGrep<CR>

" Grepper mapping
nnoremap <Space>s<Space>Gs :Grepper<Space>


" GDB
packadd termdebug

" Enable auto save
let g:auto_save = 1


""" Other customization
set incsearch
set hlsearch " highlight the previous search. turn off the current highlight with :nohlsearch

" directory local
set exrc


" show cursor status
set ruler
" what commands did I type
set showcmd

" enable mouse
set mouse=a

" long history for :
set history=5000

colorscheme onedark

" set a ruler
set colorcolumn=120

set syntax=on
" show line numbers
set number

" configure ripgrep as external grep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat+=%f:%l:%c:%m

" font used by GVim
set guifont=Cascadia_Mono:h11
" X11 * clipboard, + Windows clipboard
set clipboard=unnamedplus

runtime! ftplugin/man.vim

""" machine-specific configuration may be configured in this file
if filereadable(expand("~/.site_vimrc"))
	source ~/.site_vimrc
endif
