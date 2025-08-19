let mapleader = ' '

" directory local
set exrc

if !exists('$MYVIMRC')
    let $MYVIMRC = '~/.vimrc'
endif
if !exists('$MYVIMDIR')
    let $MYVIMDIR = '~/.vim'
endif
if has('nvim')
    set rtp+=~/.vim/after
    set rtp+=~/.vim/ftplugin
endif
" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" {{{ Vundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'will133/vim-dirdiff'
Plugin 'embear/vim-localvimrc'

" conditionally toggle relativenumber for fast cursor motion
Plugin 'jeffkreeftmeijer/vim-numbertoggle'

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
Plugin 'OmniSharp/Omnisharp-vim'
" C#
Plugin 'nickspoons/vim-cs'
Plugin 'heaths/vim-msbuild'
" Common Lisp
Plugin 'vlime/vlime', {'rtp': 'vim/'}
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
"Debugger
Plugin 'puremourning/vimspector'
" Orgmode support
if !has('nvim')
  Plugin 'jceb/vim-orgmode'
endif
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
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

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
if v:version >= 910
  " easy comment :h comment.txt
  packadd! comment
  " auotmatically turn off search hightlight 
endif
if v:version >= 910 || has('nvim')
  packadd! nohlsearch
endif
""" }}} 

" {{{ LSP, DAP, Linting
let g:lsp_use_native_client = 1

let g:ale_linters = {'cs': ['OmniSharp']}
let g:ale_virtualtext_cursor = 'disabled'

" set up vim-lsp keys
function! s:on_lsp_buffer_enabled() abort
    autocmd!
    if b:current_syntax == 'cs'
      return
    endif

    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> <leader>gd <plug>(lsp-definition)
    nmap <buffer> <leader>gs <plug>(lsp-document-symbol-search)
    nmap <buffer> <leader>gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> <leader>gr <plug>(lsp-references)
    nmap <buffer> <leader>gi <plug>(lsp-implementation)
    nmap <buffer> <leader>gd <plug>(lsp-type-definition)
    nmap <buffer> <leader>g. <plug>(lsp-code-action)
    nmap <buffer> <leader>gD :LspDocumentDiagnostics<Enter>
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> <leader>[g <plug>(lsp-previous-diagnostic)
    nmap <buffer> <leader>]g <plug>(lsp-next-diagnostic)
    nmap <buffer> <leader>K <plug>(lsp-hover)
		nmap <expr><buffer> <c-d> popup_list()->empty() ? '<c-d>' : lsp#scroll(+4)
    nmap <expr><buffer> <c-u> popup_list()->empty() ? '<c-u>' : lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
	  let g:lsp_diagnostics_enabled = 1
	  let g:lsp_diagnostics_echo_cursor = 1
	  let g:lsp_diagnostics_float_cursor = 1
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    autocmd!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Set up vimspector for debugging
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_base_dir='~/.vim/bundle/vimspector'

" Common Lisp
if !executable('sbcl') && executable('ecl')
    let g:vlime_cl_impl='ecl'
    function! VlimeBuildServerCommandFor_ecl(vlime_loader, vlime_eval)
        return ['ecl', '--load', a:vlime_loader, '--eval', a:vlime_eval]
    endfunction
endif

" GDB
if !has('nvim')
  packadd termdebug
endif

" set up asynccomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
"}}}
" {{{ Search keys
" FZF mapping

command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number -- '.fzf#shellescape(<q-args>),
      \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" search for files
nnoremap <Leader>sf :Files<CR>
" search for lines
nnoremap <Leader>ss :BLines<CR>
" ripgrep in the current directory
nnoremap <Leader>sp :Rg<CR>
" git ls-files
nnoremap <Leader>g<Leader> :GFiles<CR>
" search for tags in the current directory
nnoremap <Leader>tp :Tags<CR>
" git grep
nnoremap <Leader>sg :GGrep<CR>
" Grepper mapping
nnoremap <Leader>sG :Grepper<Space>
"}}}

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

""" {{{Custom key mapping
" Enable auto save
set autowrite
let g:auto_save = 1

map <C-n> :NERDTreeToggle<CR>

" edit certain files.
nnoremap <Leader>ev :tabe $MYVIMRC<Enter>
nnoremap <Leader>efv :tabe ~/.filetype_vimrc<Enter>
nnoremap <Leader>esv :tabe ~/.site_vimrc<Enter>
" Insert mode custom mapping (Emacs-style)
inoremap <C-b> <Left>
inoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

inoremap jk <Esc>
"}}}
""" {{{ miscelaneous
""" Other customization
set incsearch
set hlsearch " highlight the previous search. turn off the current highlight with :nohlsearch


" show cursor status
set ruler
" what commands did I type
set showcmd

" I want case-insensitive search
set ignorecase

" enable mouse
set mouse=a

" long history for :
set history=5000

" set a ruler
set colorcolumn=120

" true colors and one dark
set termguicolors
colorscheme onedark
" show line numbers
set number

" configure ripgrep as external grep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat+=%f:%l:%c:%m
set hidden

" X11 * clipboard, + Windows clipboard
set clipboard=unnamedplus

runtime! ftplugin/man.vim

" Set up proper encodings
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
"}}}
" {{{ source other scripts
""" filetype specific settings
if filereadable(expand("~/.filetype_vimrc"))
	source ~/.filetype_vimrc
endif

""" machine-specific configuration may be configured in this file
if filereadable(expand("~/.site_vimrc"))
	source ~/.site_vimrc
endif
"}}}
