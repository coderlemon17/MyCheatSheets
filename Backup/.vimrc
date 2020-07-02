"settings
set number
colorscheme desert
set guifont=Courier_new:h20:b:cDEFAULT
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
"let g:mapleader = "\<space>"


" Tab and space
set ts=4
set expandtab
set autoindent

"Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_disable_startup_warning = 1

"Plug 'liuchengxu/vim-which-key'

Plug 'tpope/vim-fugitive'

Plug 'preservim/nerdtree'
    " mapping
    nmap <C-t> :NERDTreeToggle<CR>
    " open nerdtree automatically except for a directory
    autocmd VimEnter * if argc() != 1 || !isdirectory(argv()[0]) | NERDTree | endif
    autocmd VimEnter * if argc() != 1 || !isdirectory(argv()[0]) | wincmd l | call lightline#update() | endif
    " close if no files open
    " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'

Plug 'junegunn/fzf'

Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

Plug '907th/vim-auto-save'
let g:auto_save = 0
"let g:auto_save_silent = 1  " do not display the auto-save notification
let g:auto_save_events = ["InsertLeave", "TextChanged"]

Plug 'sirver/ultisnips'
    let g:UltiSnipsExpandTrigger='<tab>'
    let g:UltiSnipsJumpForwardTrigger='<tab>'
    let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
    let g:UltiSnipsSnippetDirectories=['UltiSnips']

Plug 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=1
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none
    "setlocal spell
    "set spelllang=en_us
    " <Ctrl + l> is the shortcuts for auto-correction
    inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Using plug
" Plug 'dylanaraps/wal.vim'
"   set background=darki

Plug 'altercation/vim-colors-solarized'
   set background=dark
   let g:solarized_termcolors=256

Plug 'sickill/vim-monokai'

Plug 'vimwiki/vimwiki'

Plug 'junegunn/goyo.vim'
    nmap <C-g> : Goyo<CR>

Plug 'junegunn/limelight.vim'
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
    nnoremap <Leader>l : Limelight<CR>
    nnoremap <Leader>ql : Limelight!<CR>
    let g:limelight_default_coefficient = 0.7
    let g:limelight_paragraph_span = 2

Plug 'itchyny/lightline.vim'
" always has status line
set laststatus=2
set shortmess+=F
if !has('gui_running')
  set t_Co=256
endif
" hide original line
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

Plug 'junegunn/fzf.vim'
nnoremap <Leader>ff :Files $PWD<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fl :Lines<CR>
nnoremap <Leader>fcl :BLines<CR>
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

"Plug 'ervandew/supertab'
"let g:SuperTabDefaultCompletionType = "<c-n>"

Plug 'KabbAmine/vullScreen.vim'




" Line ends here. Plugins become visible to Vim after this call.
call plug#end()

" for colorscheme
"colorscheme solarized
colorscheme monokai
"colorscheme onedark



" Vim Key Binding

" windown navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-+> <C-w>+
map <C--> <C-w>-

" tab navigation
" new tab // next tab // pre tab // split tab
nmap tt :tabnew<CR>
nmap tn :tabn<CR>
nmap tp :tabp<CR>
nmap ts :tab split<CR>
nmap tc :tabc<CR>




