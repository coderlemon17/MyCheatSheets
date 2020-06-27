"settings
set number
colorscheme desert
set guifont=Courier_new:h20:b:cDEFAULT
set nocompatible
filetype plugin on
syntax on
"let g:mapleader = "\<space>"

"Plygins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Plug 'liuchengxu/vim-which-key'

Plug 'tpope/vim-fugitive'

Plug 'preservim/nerdtree'

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
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
    let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

Plug 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=1
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none
    "setlocal spell
    "set spelllang=en_us
    " <Ctrl + l> is the shortcuts for auto-correction
    inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Using plug
Plug 'dylanaraps/wal.vim'
    set background=dark

Plug 'vimwiki/vimwiki'


" Line ends here. Plugins become visible to Vim after this call.
call plug#end()

colorscheme wal

