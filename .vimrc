" /////////////////////////////////////////////////////////////////////////////////////////////////
" // Plugins will be downloaded at the specified directory
" /////////////////////////////////////////////////////////////////////////////////////////////////
call plug#begin('~/.vim/plugged')

" Declare the list of plugins
" Gruvbox and YouCompleteMe need to be installed beforehand:
"   - https://github.com/morhetz/gruvbox
"   - https://github.com/ycm-core/YouCompleteMe
Plug 'ycm-core/YouCompleteMe'
Plug 'preservim/nerdtree'
Plug 'gruvbox-community/gruvbox'
Plug 'pangloss/vim-javascript'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" List ends here. Plugins become visible to Vim after this call
call plug#end()

" /////////////////////////////////////////////////////////////////////////////////////////////////
" // Gruvbox configurations
" /////////////////////////////////////////////////////////////////////////////////////////////////
set termguicolors
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox
set background=dark

" /////////////////////////////////////////////////////////////////////////////////////////////////
" // Airline configurations
" /////////////////////////////////////////////////////////////////////////////////////////////////
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1

" /////////////////////////////////////////////////////////////////////////////////////////////////
" // Clipboard configurations
" /////////////////////////////////////////////////////////////////////////////////////////////////
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif

  if has('unix')
    " Copies the contents of the + register to the system clipboard after VIM exits
    " with xclip. Requires xclip to be installed.
    autocmd VimLeave * call system('echo ' . shellescape(getreg('+')) . 
        \ ' | xclip -selection clipboard')
  endif
endif

" /////////////////////////////////////////////////////////////////////////////////////////////////
" // Nerdtree plugin settings
" /////////////////////////////////////////////////////////////////////////////////////////////////
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") 
    \ | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) 
    \ | q | endif
nnoremap ./ :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" /////////////////////////////////////////////////////////////////////////////////////////////////
" // Search-related configurations
" /////////////////////////////////////////////////////////////////////////////////////////////////
set hlsearch " Highlight matching search patterns
set incsearch " Enable incremental search
set ignorecase " Include matching uppercase words with lowercase search term
set smartcase " Include only uppercase words with uppercase search term

" Maps the Enter key to toggle highlight on/off for the current word, without
" moving the cursor. Extracted from
" https://vim.fandom.com/wiki/Highlight_all_search_pattern_matches
let g:highlighting = 0
function! Highlighting()
  if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
  endif
  let @/ = '\<'.expand('<cword>').'\>'
  let g:highlighting = 1
  return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> <CR> Highlighting()

" /////////////////////////////////////////////////////////////////////////////////////////////////
" // Miscellaneous configurations
" /////////////////////////////////////////////////////////////////////////////////////////////////
set encoding=utf-8

set number
set relativenumber
set nocompatible
syntax enable
filetype plugin on
set path+=**
set whichwrap=<,>,[,],h,l " Makes h/j/left arrow/right arrow wrap around lines
set showmode " Display current mode
set showcmd " Display partial command
set list listchars=tab:>-,trail:•,extends:+,eol:¬ " Display different types of white spaces.
set ls=2 " Enable status bar
set ru " Enable the ruler
set mouse=a " Enable the mouse

" Makes backspace work as expected
map <BS> X
set bs=2

" Indentation-related configurations
set autoindent " Carry indentation over from previous line on line break
set tabstop=2 " Width of tab character
set softtabstop=2 " Fine tunes the amount of white space to be added
set shiftwidth=2 " Determines the amount of whitespace to add in normal mode
set expandtab " When on uses space instead of tabs

" Key mappings to stop arrows in normal and visual mode
nnoremap <Left> :echoerr "Stop being stupid!"<CR>
vnoremap <Left> :<C-u>echoerr "Stop being stupid!"<CR>
nnoremap <Right> :echoerr "Stop being stupid!"<CR>
vnoremap <Right> :<C-u>echoerr "Stop being stupid!"<CR>
nnoremap <Up> :echoerr "Stop being stupid!"<CR>
vnoremap <Up> :<C-u>echoerr "Stop being stupid!"<CR>
nnoremap <Down> :echoerr "Stop being stupid!"<CR>
vnoremap <Down> :<C-u>echoerr "Stop being stupid!"<CR>

" Map Ctrl+h, Ctrl+j, Ctrl+k and Ctrl+l to move between panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Configurations for autocomplete of filenames
set wildmode=longest,list
set foldmethod=syntax
set foldlevelstart=99

" Disable word wrapping and improve sidescrolling
set nowrap
set sidescroll=5
set listchars+=precedes:<,extends:>
