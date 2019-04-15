filetype off

"VUNDLE-------------------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

"Theming plugins
Plugin 'https://github.com/nanotech/jellybeans.vim.git'

"Preview for substitution
Plugin 'https://github.com/markonm/traces.vim.git'

"Code Autocompletion
Plugin 'Valloric/YouCompleteMe'

"Syntax checking
Plugin 'https://github.com/vim-syntastic/syntastic.git'

"Rust support
Plugin 'rust-lang/rust.vim'

call vundle#end()
filetype plugin indent on
"VUNDLE-END---------------------------------------------------------

"YOUCOMPLETEME------------------------------------------------------
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 100
let g:ycm_show_diagnostics_ui = 1
let g:ycm_confirm_extra_conf = 0

"let g:ycm_filetype_blacklist = { 'java': 1 }
"YOUCOMPLETEME-END--------------------------------------------------

"SYNTASTIC----------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['python', 'pylint']
let g:syntastic_python_pylint_args = "-E"
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": ["rust"],
    \ "passive_filetypes": [] }

let g:syntastic_ruts_checkers = ['cargo']

"SYNTASTIC-END------------------------------------------------------

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
