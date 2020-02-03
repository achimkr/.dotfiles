filetype on
let mapleader = " "

""Plug-vim-------------------------------------------------------------
call plug#begin('~/.vim/plugged')

"Theming plugins
Plug 'https://github.com/nanotech/jellybeans.vim.git'

"Preview for substitution
Plug 'https://github.com/markonm/traces.vim.git'

"Fuzzyfind
"Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'

Plug 'airblade/vim-rooter'

" Autocomplete
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"Rust
Plug 'rust-lang/rust.vim' 
nnoremap <LEADER>f :RustFmt<CR>

"Language Server
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

"GPG 
Plug 'https://github.com/jamessan/vim-gnupg'

"Idris
Plug 'https://github.com/idris-hackers/idris-vim'

call plug#end()
filetype plugin indent on
"VUNDLE-END---------------------------------------------------------

"LanguageClient-neovim----------------------------------------------
let g:LanguageClient_serverCommands = {
    \ 'rust': ['ra_lsp_server'],
    \ 'cpp': ['clangd'],
    \ 'c': ['clangd'],
    \ }
    "\ 'java': ['jdtls', '-data', getcwd()],
    "\ 'rust': ['rustup', 'run', 'stable', 'rls'],


function SetLSPShortcuts()
	if has_key(g:LanguageClient_serverCommands, &filetype)
		nnoremap gd :call LanguageClient#textDocument_definition()<CR>
		nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>
		"nnoremap <leader>f :call LanguageClient#textDocument_formatting()<CR>
		nnoremap <leader>t :call LanguageClient#textDocument_typeDefinition()<CR>
		nnoremap <leader>x :call LanguageClient#textDocument_references()<CR>
		nnoremap <leader>a :call LanguageClient_workspace_applyEdit()<CR>
		nnoremap <leader>c :call LanguageClient#textDocument_completion()<CR>
		nnoremap <leader>t :call LanguageClient#textDocument_hover()<CR>
		nnoremap <leader>S :call LanguageClient_textDocument_documentSymbol()<CR>
		nnoremap <leader>M :call LanguageClient_contextMenu()<CR>
	endif
	nnoremap <F5> :call LanguageClient_contextMenu()<CR>
	" Or map each action separately
	nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
	nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
	nnoremap <silent> T :call LanguageClient#textDocument_hover()<CR>
endfunction()

autocmd FileType rust,cpp,c call SetLSPShortcuts()
"LanguageClient-neovim----------------------------------------------

function SetUpIdris()
	nnoremap T \t
endfunction()

autocmd FileType idris call SetUpIdris()

"FZF----------------------------------------------------------------
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <LEADER>s :FZF<CR>
"FZF----------------------------------------------------------------

"DEOPLETE-----------------------------------------------------------
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
"DEOPLETE-----------------------------------------------------------

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

inoremap jk <esc>

set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

"Hide search highlighting
nnoremap ä :nohls<CR>

"Center buffer
nnoremap <SPACE><SPACE> zz

"Delete trailing whitespace
command! Trim %s/\s\+$//g

"Swapping text
vnoremap <C-X> <Esc>`.``gvP``P
"Create End Tag in html files
"autocmd BufReadPost *.html inoremap > ><ESC>F<lywf>a</<ESC>pa><ESC>F<i
