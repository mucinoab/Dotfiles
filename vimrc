"vim plug
call plug#begin('~/.vim/plugged')
"Plug 'mhartington/oceanic-next'
Plug 'glepnir/zephyr-nvim'
"Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
"Plug 'nathom/filetype.nvim'
"Plug 'edkolev/tmuxline.vim'
Plug 'SirVer/ultisnips', { 'for': ['tex', 'latex'] }
Plug 'lervag/vimtex', { 'for': ['tex', 'latex']}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ojroques/nvim-bufdel'
Plug 'airblade/vim-rooter'
"Plug 'Chiel92/vim-autoformat'
Plug 'romgrk/barbar.nvim'
Plug 'chaoren/vim-wordmotion'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'l3mon4d3/luasnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'lukas-reineke/cmp-under-comparator'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'ray-x/lsp_signature.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'rmagatti/auto-session'
Plug 'nvim-lualine/lualine.nvim'
"Plug 'SmiteshP/nvim-gps' " TODO https://github.com/SmiteshP/nvim-navia
Plug 'phaazon/hop.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'shaunsingh/solarized.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-repeat'
Plug 'petertriho/nvim-scrollbar'
Plug 'j-hui/fidget.nvim'
Plug 'mvllow/modes.nvim'
Plug 'theprimeagen/jvim.nvim'
Plug 'lukas-reineke/lsp-format.nvim'
Plug 'simrat39/rust-tools.nvim'
Plug 'zaldih/themery.nvim'
"Plug 'nvim-treesitter/playground'
Plug 'github/copilot.vim'
" Plug 'zbirenbaum/copilot.lua'
"Plug 'zbirenbaum/copilot-cmp'
Plug 'nvim-tree/nvim-tree.lua'
call plug#end()


lua require('config')

vmap j gj
vmap k gk
nmap j gj
nmap k gk
map q: :q
map Q <Nop>
inoremap jk <esc>

let mapleader = "\<Space>"

"borrar palabra completa 
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

nnoremap Y y$

"exit con Q
:command Q q

" mantienen el cursor en el centro al iterar en búsquedas
nnoremap n nzzzv
nnoremap N Nzzzv

"control j-k para mover lineas y selecciones completas
nnoremap <silent><C-j> :m .+1<CR>==
nnoremap <silent><C-k> :m .-2<CR>==
inoremap <silent><C-k> <Esc>:m .-2<CR>==gi
inoremap <silent><C-j> <Esc>:m .+1<CR>==gi
vnoremap <silent><C-j> :m '>+1<CR>gv=gv
vnoremap <silent><C-k> :m '<-2<CR>gv=gv

"moverte entre splits
map <C-h> <C-W>h
map <C-l> <C-W>l

syntax on
"set relativenumber
set hidden
set synmaxcol=400
"set mouse=a
set clipboard=unnamedplus
set shiftwidth=2
set tabstop=2
set nohlsearch
"set virtual edit=all
set encoding=utf-8
set laststatus=2
set noshowmode
set scrolloff=5
set undofile
set cursorline
set number
set autoindent
set smarttab
set smartindent
set ruler
set title
set showcmd
set showmatch
set autoread
set expandtab
set shiftround
set lazyredraw
set termguicolors
set showtabline=2
set colorcolumn=99999

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

set redrawtime=10000
set updatetime=100
set shortmess+=c

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

set completeopt=menuone,noinsert,noselect

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.orig set readonly
autocmd BufRead *.pacnew set readonly

"cosas para editar texto simple, no código
filetype plugin indent on
autocmd BufRead *.tex,*.latex set filetype=tex
autocmd BufRead *.typ set filetype=typst
au BufRead,BufNewFile *.txt,*.tex,*.latex,*.md,*.typ set wrap linebreak nolist tw=79 wrapmargin=0 lbr fo=tro nonumber nornu

let g:latex_indent_enabled = 1

set spell
set spelllang=es,en
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u<Esc>ha

" Jump to start and end of line using the home row keys
map H g^
map L g$

" Repeat f/F with .
nnoremap <Plug>NextMatch ;
nnoremap <silent> F :<C-u>call repeat#set("\<lt>Plug>NextMatch")<CR>F
nnoremap <silent> f :<C-u>call repeat#set("\<lt>Plug>NextMatch")<CR>f

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 350})
augroup END

colorscheme zephyr
"colorscheme OceanicNext
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1

" Enable type inlay hints
" autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
"  \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Goto previous/next diagnostic warning/error
nnoremap <silent>g{ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent>g} <cmd>lua vim.diagnostic.goto_next()<CR>

nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>k <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>e <cmd>lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"}) <CR>

nmap <leader>d <cmd>BufferPick<CR>

let g:vimtex_format_enabled=1
let g:vimtex_fold_manual=1
let g:vimtex_compiler_latexmk = {'build_dir' : 'build',}
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
let g:vimtex_view_method='zathura'
set conceallevel=0
let g:tex_conceal="abdgm"
let g:UltiSnipsSnippetDirectories=['~/Dotfiles/snips']
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

let g:tmuxline_preset = 'minimal'
let g:tmuxline_theme = {
      \   'a'    : [ 236, 236 ],
      \   'b'    : [ 253, 239 ],
      \   'c'    : [ 244, 236 ],
      \   'x'    : [ 244, 236 ],
      \   'y'    : [ 253, 239 ],
      \   'z'    : [ 236, 102 ],
      \   'win'  : [ 102, 236 ],
      \   'cwin' : [ 236, 102 ],
      \   'bg'   : [ 244, 236 ],}

hi clear Spell Bad
hi SpellBad cterm=underline  ctermfg=Red

"desactiva las flecha
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <left> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Quick-save y salir con C-espacio
nmap <leader>w :w<CR>
nmap <C-Space> :call CloseIfEmpty()<CR>
imap <C-Space> <Esc>:call CloseIfEmpty()<CR>
"nmap <leader>t :ene <CR> :file new<CR>

"navegar entre buffers.
map <leader><Tab> :BufferNext<CR>
map <leader><S-Tab> :BufferPrevious<CR>
nmap <leader><leader> <c-^>
tnoremap <leader><leader> <C-\><C-n><c-^>

"telescope find f-ile, s-earch, b-uffer, g-it s-tatus, h-istory
nmap <leader>f  <cmd>lua require('telescope.builtin').find_files({ layout_strategy='vertical' }) <cr>
nmap <leader>s  <cmd>lua require('telescope.builtin').live_grep({ layout_strategy='vertical' }) <cr>
nmap <Leader>b  <cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({}))<cr>
nmap <leader>ld <cmd>Telescope diagnostics<cr>
nmap <leader>p  <cmd>Telescope session-lens search_session<cr>
nmap <Leader>r  <cmd>lua require'telescope.builtin'.lsp_references()<cr>

highlight TelescopeSelectionCaret guifg=#ff3333
highlight TelescopeSelection      guifg=#D79921 gui=bold,underline
highlight TelescopePreviewLine    guifg=#D79921 gui=underline

"cierra buffer actual y solo lo guarda si no esta vacío.
"también cierra vim si solo queda un buffer y esta vacío:wq
fu! CloseIfEmpty()
  exec 'w'
  let nbuffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
  if nbuffers == 1
    exec 'BufDel'
  else 
    exec 'BufferClose'
  endif
endfu

autocmd Filetype cs setlocal tabstop=4 shiftwidth=4

" No spell check for programming languages
autocmd Filetype cs,rs,js,py,go,ts,cpp  set nospell

let g:indent_blankline_filetype = ['cpp', 'python', 'rust', 'go', 'javascript', 'typescript', 'cs', 'c']
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:indent_blankline_use_treesitter = v:true

" Jump to last edit position on opening file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif
endif

map <silent> <C-F> :NvimTreeToggle<CR>
nmap <leader>m <cmd>HopChar1<cr>

augroup HiglightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
augroup END

highlight MatchParen gui=underline guibg=NONE guifg=red

autocmd FileType json nnoremap <left>  :lua require("jvim").to_parent()   <CR>
autocmd FileType json nnoremap <right> :lua require("jvim").descend()     <CR>
autocmd FileType json nnoremap <up>    :lua require("jvim").prev_sibling()<CR>
autocmd FileType json nnoremap <down>  :lua require("jvim").next_sibling()<CR>

" Don't touch unnamed register when pasting over visual selection
xnoremap <expr> p 'pgv"' . v:register . 'y'
