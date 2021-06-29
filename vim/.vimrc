" vim:foldmethod=marker:foldlevel=0

"" General {{{

set encoding=utf-8
set nocompatible                    " set compatibility to vim only (not vi)
set showmode                        " display mode outside of normal mode
syntax enable                       " enable syntax processing
set title                           " set windows title to reflect filename
set history=2000                    " 2000 history items (: commands, search strings, inputlines...)
set mouse=a                         " enable mouse for scrolling, pointing and resizing

filetype plugin on                  " enable plugins for filetypes

" set to autoread when a file is changed from outside
set autoread
au FocusGained,BufEnter * checktime

let mapleader = ","

" Store info from no more than 200 files at a time, 14999 lines of text, 10mb of data. Useful for copying large amounts of data between files.
set viminfo='200,<14999,s10000


" }}}


"" Colors {{{

" colorscheme solarized
set termguicolors                   " uses terminal fg and bg colors
set background=dark                 " use colors that suit a dark background
colorscheme solarized               " use Solarized color scheme


" }}}

"" Misc {{{

set confirm                         " display confirmation when closing an unsaved file
set noswapfile                      " don't store swap files
set nobackup                        " don't store swap files
set undodir=~/.vim/undodir          " folder for undo files
set undofile                        " create an undo file per actual file
set scrolloff=8                     " context lines around the cursor before "moving" the document
set sidescrolloff=5                 " same than scrolloff but horizontally

set noerrorbells                    " no bell
set novisualbell                      

set ttyfast                         " speed up scrolling in vim
set nowrap                          " don't wrap long lines
" }}}

"" Spaces and tabs {{{

set tabstop=4                       " number of visual spaces per tab
set softtabstop=4                   " number of spaces per tab when editing
set expandtab                       " tabs are spaces
set smarttab                        " when deleting whitespace at the beginning of the line, delete 1 tab worth of spaces
set autoindent                      " copy indentation from line above when creating a new line 

filetype indent on                  " load filetype-specific indent files

set modelines=1

" }}}


"" UI Layout {{{

set number                          " show line numbers
set showcmd                         " show last command in bottom bar
set cursorline                      " highlight current line


set wildmenu                        " visual autocomplete for command menu
set wildignore=*.o,*.~,*.pyc
set wildignore+=*/.git/*,*/.DS_Store

set lazyredraw                      " don't redraw if it isn't necessary

set showmatch                       " show matching brackets

set laststatus=2                    " always display status bar
set ruler                           " display cursor position
set cmdheight=1                     " command bar height

" Display marker after column 80, and hard marker after column 120
set colorcolumn=81                  
highlight ColorColumn ctermbg=0 guibg=lightgrey
let &colorcolumn="81,".join(range(120,999),",")  

" }}}

"" Searching {{{

set incsearch                       " search as characters are entered
set ignorecase                      " ignore case when searching
set hlsearch                        " highlight matches
set smartcase                       " automatically switch to case-sensitive when search query contains an uppercase letter

" }}}

"" Folding {{{

set foldenable                      " enable code folding
set foldlevelstart=10               " open most folds by default
set foldnestmax=10                  " 10 nested folds max
set foldmethod=syntax               " syntax based folding

nnoremap <space> za                 " space open/closes folds

" }}}

"" Line Shortcuts {{{

" }}}

"" Leader Shortcuts {{{

nnoremap <silent> <leader>ss :set spell! spell?<CR>

" }}}

"" Other Shortcuts {{{

" window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l




"" TODO: Shortcut for toggling file explorer

" }}}

"" Powerline {{{

" }}}

"" tmux {{{

" }}}


"" Custom functions {{{

" }}}

"" Plugin configs {{{
let g:mundo_preview_bottom=1            " displays undo preview at the bottom for more space

" }}}

"" Plugin shortcuts {{{

nnoremap <leader>u :MundoToggle<CR>     " Toggle vim-mundo undo tree

"}}}


"" UI Settings

let g:fern#renderer = "nerdfont"

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END



""" TODO

" Toggle line wrap
" Toggle spell checking
" airline or alternative that works with nerdfont.vim
" copy paste from OS logic from gpakosz?
" add command to reload/edit .vimrc
" plugin lazy loading with vim8


""" PLUGINS

" vim-ripgrep
" ctrlp
" vim-fugitive
" vim-man
" undotree ==> Superseeded by vim-mundo (gundo fork)  https://simnalamburt.github.io/vim-mundo/#requirements
" youcompleteme/coc ==> code navigation
" ripgrep/ag
" TF syntax
" bash syntax

"" FROM: https://www.youtube.com/watch?v=n9k9scbTuvQ
" nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>      " Opens file browser and resizes it
" nnoremap <leader>ps :Rg<SPACE>                                            " Opens ripgrep
" nnoremap <silent><leader>+ :vertical resize +5
" nnoremap <silent><leader>- :vertical resize -5
