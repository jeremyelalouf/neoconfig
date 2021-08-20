"-------------------------------- PLUGINS ------------------------------
"
call plug#begin('~/.config/nvim/plugins')
Plug 'vim-scripts/bats.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
call plug#end()
"---------------------------- GENERAL SETTINGS --------------------------
"
inoremap ² <Esc>
map ; :Files<CR>
set number
set swapfile
set dir=~/.config/nvim/tmp/
set relativenumber
set rnu
"---------------------------------- LSP ---------------------------------
"
lua << EOF
require'lspconfig'.hls.setup{on_attach=require'completion'.on_attach}
EOF
"----------------- RECOMMENDED COMPLETION-NVIM SETTINGS -----------------
"
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
" Selects matches rules
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
"------------------------------------------------------------------------
