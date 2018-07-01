"VUNDLE-------------------------------------------------------------
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

"Theming plugins
Plugin 'https://github.com/chriskempson/base16-vim.git'
Plugin 'https://github.com/nanotech/jellybeans.vim.git'

"Preview for substitution
Plugin 'https://github.com/markonm/traces.vim.git'

"File Explorer
Plugin 'https://github.com/scrooloose/nerdtree.git'

"Code Autocompletion
Plugin 'Valloric/YouCompleteMe'

"Syntax checking
Plugin 'https://github.com/vim-syntastic/syntastic.git'

"Surrounding
Plugin 'https://github.com/tpope/vim-surround.git'

"Git integration
Plugin 'https://github.com/tpope/vim-fugitive.git'

call vundle#end()
filetype plugin indent on
"VUNDLE-END---------------------------------------------------------

"YOUCOMPLETEME------------------------------------------------------
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_show_diagnostics_ui = 1
"YOUCOMPLETEME-END--------------------------------------------------

"SYNTASTIC------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_mode_map = {
	\ "mode": "active",
	\ "active_filetypes": [],
	\ "passive_filetypes": ["tex"] }

"Only show Errors in python; -E Flag
let g:syntastic_python_pylint_args= "-E"
"SYNTASTIC-END--------------------------------------------------

"Theming
set t_Co=256
set termguicolors
colorscheme jellybeans

"BASIC Settings
set softtabstop=4
set tabstop=4
set shiftwidth=4
set linebreak
syntax on
set number
set ruler
set autoindent
set clipboard=unnamedplus
set hlsearch

"Show whitespace
set listchars=tab:▏\ ,trail:·
set list

set cursorline

"intuitive paragraph jumping
nnoremap <C-j> }
vnoremap <C-j> }
nnoremap <C-k> {
vnoremap <C-k> {

"intuitive line start/end jumping
nnoremap <C-l> $
vnoremap <C-l> $
nnoremap <C-h> ^
vnoremap <C-h> ^

"Create End Tag in html files
autocmd BufReadPost *.html inoremap > ><ESC>F<lywf>a</<ESC>pa><ESC>F<i

