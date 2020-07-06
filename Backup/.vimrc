"settings
" absolute numbsr
set number
nnoremap <Leader>an : set number!<CR>
" relative number
set relativenumber
colorscheme desert
"set guifont=Courier_new:h20:b:cDEFAULT
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
let g:mapleader = "\<space>"

" Tab and space
set ts=4
set expandtab
set autoindent
" For << and >>
set softtabstop=4
set shiftwidth=4

" For cursor
autocmd VimEnter * silent exec "!echo -ne '\e[1 q'"

" For opacity
autocmd VimEnter * silent exec "!transset -a --inc 0.19"
autocmd VimLeave * silent exec "!transset -a --dec 0.19"

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
    " autocmd VimEnter * if argc() != 1 || !isdirectory(argv()[0]) | NERDTree | endif
    " autocmd VimEnter * if argc() != 1 || !isdirectory(argv()[0]) | wincmd l | call lightline#update() | endif
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
    " Latex
    autocmd Filetype tex setlocal spell | set spelllang=en_us | AutoSaveToggle
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
let g:vimwiki_list = [{'path': '/home/lemon/Workspace/myCheatSheet/Wiki', 'path_html': '/home/lemon/Workspace/myCheatSheet/Wiki/html', 'syntax': 'markdown', 'ext': '.md'}]

" disable the <tab> mapping provided by vimwiki, which interferes with SuperTab
let g:vimwiki_table_mappings = 0
" whether to treat all md files as vimwiki
let g:vimwiki_global_ext = 1

Plug 'junegunn/goyo.vim'
    nmap <C-g> : Goyo<CR>

Plug 'junegunn/limelight.vim'
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
    nnoremap <Leader>l : Limelight<CR>
    nnoremap <Leader>ql : Limelight!<CR>
    let g:limelight_default_coefficient = 0.7
    let g:limelight_paragraph_span = 5

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
nnoremap <Leader>fc :Ag<CR>
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"
"let g:SuperTabMappingForward = "<T>"

Plug 'easymotion/vim-easymotion'
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)

map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)




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
" new tab // next tab // pre tab // split tab // close tab // move
" forward/backward
nmap tt :tabnew<CR>
nmap tn :tabn<CR>
nmap tp :tabp<CR>
nmap ts :tab split<CR>
nmap tc :tabc<CR>
nmap tl :tabm -1<CR>
nmap tr :tabm +1<CR>


" for copy / paste to system clipboard
nnoremap <Leader>y "+yy
nnoremap <Leader>p "+p

