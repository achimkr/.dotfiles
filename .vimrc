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
Plugin 'https://github.com/kien/ctrlp.vim.git'

"Code Autocompletion
Plugin 'Valloric/YouCompleteMe'

"Syntax checking
Plugin 'https://github.com/vim-syntastic/syntastic.git'

"Git integration
Plugin 'https://github.com/tpope/vim-fugitive.git'

call vundle#end()
filetype plugin indent on
"VUNDLE-END---------------------------------------------------------

"NERDTREE-----------------------------------------------------------
nnoremap ü :NERDTreeToggle<CR>

"NERDTREE-END-------------------------------------------------------

"YOUCOMPLETEME------------------------------------------------------
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_show_diagnostics_ui = 1
let g:ycm_confirm_extra_conf = 0
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
	\ "passive_filetypes": ["tex", "java"] }

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
set autoindent

set number
set relativenumber
noremap <C-n> :set relativenumber!<CR>

set clipboard=unnamedplus

set hlsearch

syntax on


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

"Hide search highlighting
nnoremap ä :nohls<CR>

"Delete trailing whitespace
command! Trim %s/\s\+$//g

"Create End Tag in html files
autocmd BufReadPost *.html inoremap > ><ESC>F<lywf>a</<ESC>pa><ESC>F<i
