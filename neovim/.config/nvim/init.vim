
let g:python3_host_prog=$HOME.'/.venv/bin/python3'

" # PLUGINS

" install vim-plug if not found 
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'lifepillar/vim-solarized8'                    " colorscheme
Plug 'simnalamburt/vim-mundo'						" undo tree
Plug 'lambdalisue/fern.vim'							" file explorer
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'itchyny/lightline.vim'

" telescope.nvim
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Languages and filetypes
Plug 'chrisbra/csv.vim'
Plug 'ekalinin/dockerfile.vim'

" git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

call plug#end()


" # GENERAL
set encoding=utf-8
set nocompatible                    " set compatibility to vim only (not vi)
set nomodeline                      " disable modelines (security concerns)
set showmode                        " display mode outside of normal mode
set title                           " set windows title to reflect filename

set nrformats-=octal                " remove octal as a number format (not widely used)
set complete-=i                     " don't scan included files for autocompletion
set backspace=indent,eol,start      " backspace normally over auto inserted indents, line breaks and start of insert
"set mouse=a                         " enable mouse for scrolling, pointing and resizing

set ttyfast                         " speed up scrolling in vim
set nowrap                          " don't wrap long lines
set textwidth=0                     " don't split long lines (insert mode)

set noerrorbells novisualbell t_vb= " no bell

set confirm                         " display confirmation when closing an unsaved file

if &history < 2000
	set history=2000                " 2000 history items (: commands, search strings, inputlines...)
endif

if &tabpagemax < 50
    set tabpagemax=50               " set maximum tab pages to 50 (default is 10)
endif

" filetype detection for syntax highlighting and other options, as well as filetype-specific plugins and indentation
if has('autocmd')
    filetype plugin indent on
endif

" enable syntax processing if not enabled already.
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

" set to auto-reload when a file is changed outside
set autoread
au FocusGained,BufEnter * checktime

" set the timeout for key codes, such as Escape, Ctrl, Shift, etc
if !has('nvim') && &ttimeoutlen == -1
	set ttimeout
	set ttimeoutlen=100
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
endif

if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j            " Delete comment character when joining commented lines
endif

set noswapfile                      " don't store swap files
set nobackup                        " don't store backup files
set undodir=/tmp                    " folder for undo files
set undofile                        " create an undo file per actual file

" Store info from no more than 200 files at a time, 14999 lines of text, 10mb of data. Useful for copying large amounts of data between files.
set viminfo='200,<14999,s10000

set sessionoptions-=options         " disable saving of options, mappings and global values when using :mksession
set viewoptions-=options            " disable saving of options, mappings and global values when using :mkview

set matchpairs+=<:>

" # INTERFACE
set number                          " show line numbers
set numberwidth=5                   
set showcmd                         " show last command in bottom bar
set cursorline                      " highlight current line
set ruler                           " display cursor position
set lazyredraw                      " don't redraw if it isn't necessary
set showmatch                       " show matching brackets
set laststatus=2                    " always display status bar
set cmdheight=1                     " command bar height
set display+=lastline

set wildmenu                        " visual autocomplete for command menu
set wildignore=*.o,*.~,*.pyc
set wildignore+=*/.git/*,*/.DS_Store

" Allow colorschemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
	set t_Co=16
endif

if !&scrolloff
    set scrolloff=8                 " context lines around the cursor before 'moving' the document
endif

if !&sidescrolloff
    set sidescrolloff=5             " same than scrolloff but horizontally
endif


" Enable 24-bit true colors if your terminal supports it.
if has('termguicolors')
    " https://github.com/vim/vim/issues/993#issuecomment-255651605
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    
    set termguicolors               " uses terminal fg and bg colors
endif

set background=dark                 " use colors that suit a dark background
"colorscheme solarized8              " use Solarized color scheme
autocmd vimenter * ++nested colorscheme solarized8

" Display marker after column 80, and hard marker after column 120
set colorcolumn=81
let &colorcolumn="81,".join(range(120,999), ",")


" # INDENTATION
set expandtab                       " insert spaces instead of tabs
set tabstop=4                       " how many columns a tab should be "rendered" as (no effect on the actual text)
set shiftwidth=4                    " how many columns text will be indented when using indent operations (covers filetype indent and smarttab/smartindent)
set softtabstop=4                   " Number of spaces that a <Tab> counts for while performing editing operations
set smarttab                        " when deleting whitespace at the beginning of the line, delete 1 tab worth of spaces
set autoindent                      " copy indentation from line above when creating a new line 
set smartindent

" # FOLDING
set foldenable                      " enable code folding
set foldlevelstart=10               " open most folds by default
set foldnestmax=10                  " 10 nested folds max
set foldmethod=syntax               " syntax based folding

nnoremap <space> za                 " space open/closes folds

" # SEARCHING
set incsearch                       " search as characters are entered
set ignorecase                      " ignore case when searching
set hlsearch                        " highlight matches
set smartcase                       " automatically switch to case-sensitive when search query contains an uppercase letter

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
	" TODO: REVIEW
    nnoremap <silent> <leader><C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" # MAPPINGS
let mapleader = ","

" <leader>ev edits .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

" <leader>sv sources .vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>:runtime! plugin/*<CR>:redraw<CR>:echo $MYVIMRC 'reloaded'<CR>


" Prevent (Ctrl-U and Ctrl-W) deletion without the possibility of undoing in insert mode
if empty(mapcheck('<C-U>', 'i'))
    inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
    inoremap <C-W> <C-G>u<C-W>
endif

" window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" yank/paste to/from the OS clipboard
map <silent> <leader>y "+y
map <silent> <leader>Y "+Y
map <silent> <leader>p "+p
map <silent> <leader>P "+P

" disable arrows to get used to hjkl
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>

" disable PgUp and PgDown
nnoremap <PageUp> <Nop>
nnoremap <PageDown> <Nop>

" disable Home and End keys
nnoremap <Home> <Nop>
nnoremap <End> <Nop>

" toggle spellchecking
nnoremap <silent> <leader>ss :set spell! spell?<CR>

" scroll by visual lines, useful when wrapping is enabled
nnoremap j gj
nnoremap k gk

nnoremap oo o<Esc>k                 " insert new line below and stay in normal mode
nnoremap OO O<Esc>j                 " insert new line above and stay in normal mode




runtime! settings/*.vim				" Source plugin configs

" vim-sensible explained
" https://towardsdatascience.com/explaining-every-line-of-vim-sensible-b776affec51a


""" TODO

" Telescope
"   Show folders when using find_files
"   Change default grep utility to rg/ag
" Change match highlight color (brackets, parens, curly, angular brackets...)
" Show fern when opening vim in a folder
" Always use block cursor
" Toggle line wrap
" airline or alternative that works with nerdfont.vim
" MRU list?

""" PLUGINS

" vim-ripgrep
" vim-fugitive
" vim-man
" youcompleteme/coc ==> code navigation
" ripgrep/ag
" TF syntax
" bash syntax

"" FROM: https://www.youtube.com/watch?v=n9k9scbTuvQ
" nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>      " Opens file browser and resizes it
" nnoremap <leader>ps :Rg<SPACE>                                            " Opens ripgrep
" nnoremap <silent><leader>+ :vertical resize +5
" nnoremap <silent><leader>- :vertical resize -5

"" FROM: https://youtu.be/QN4fuSsWTbA?t=304 
" To select text between a pair of quotes, brackets, parenthesis, curly braces... (while being on the middle of them)
" vi<wrapping character>        => Select text between <wrapping characters> excluding them
" va<wrapping character>        => Select text between <wrapping characters> including them
"
" Also works with d(elete) and c(change) instead of v(visual mode)
" check "marks" in this same video
" 
