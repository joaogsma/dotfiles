" /////////////////////////////////////////////////////////////////////////////////////////////////
" // Plugins will be downloaded at the specified directory
" /////////////////////////////////////////////////////////////////////////////////////////////////
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 0
let g:airline#extensions#coc#enabled = 1

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
" // Conquer of Completion configurations
" /////////////////////////////////////////////////////////////////////////////////////////////////
" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=1000

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes

endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Set backspace to abort completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use Ctrl+Space to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)><expr> <c-space> coc#refresh()

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap rn <Plug>(coc-rename)
" File renaming. Needs watchman installed: sudo apt install watchman
nmap rnf :CocCommand workspace.renameCurrentFile<CR>

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

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
set ttymouse=xterm2 " Fixes mouse in tmux

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

" Add a grey line to the 100th column
highlight ColorColumn ctermbg=grey
set colorcolumn=100

" Maps jj to Esc in insert mode
inoremap jj <ESC>

" Highlight the current line
set cursorline
