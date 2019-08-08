" Practice:
" gi - goes back to last insert
" '. - goes to the last modification
" CTRL+E & Y (ins mod) - inserts chars from above and below line
" CTRL+T & D - indent and dedent in ins mod
" :!sort, :!grep, :!
" :.! - execute system command and add output on the current line
" "+y will copy to os clipboard
" "*p will paste from the different register

" Use Vim settings, rather then Vi settings.
" This must be first, because it changes other options as a side effect.
if &compatible
  set nocompatible
end

syntax enable

set background=dark

" Enable file type detection.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" Plugins using vim-plug
call plug#begin('~/.vim/plugged')
" Colorschemes
Plug 'joshdick/onedark.vim'
" JSON syntax
Plug 'elzr/vim-json'
" Auto-close for parens, etc.
Plug 'jiangmiao/auto-pairs'
" Alternative: https://github.com/Raimondi/delimitMate
" Fuzzy file search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" JSX syntax
Plug 'mxw/vim-jsx'
" ES6 syntax
Plug 'pangloss/vim-javascript'
" Everything git
Plug 'tpope/vim-fugitive'
" Status bar
Plug 'vim-airline/vim-airline'
" Asynchronous Lint Engine
Plug 'w0rp/ale'
Plug 'wakatime/vim-wakatime'
Plug 'prettier/vim-prettier', { 'do': 'yarn install'  }
call plug#end()

" Disable JSHint warnings:
" https://github.com/dense-analysis/ale/issues/808
let g:ale_linters = {'javascript': ['eslint']}

" Editor Properties {{{

set encoding=utf-8

set nomodeline " Disable reading vim configuration from files
set history=100 " keep 100 lines of command line history

" set autoread " Read files when they've been changed outside of Vim.

set diffopt=vertical

" # Command line
set wildmenu " see all options when auto completing with <TAB>
set wildmode=list:longest " to have the completion complete only up to the point of ambiguity
set wildmode=longest:full,full
" Ignore these files when completing names, in Explorer and in Command-T
set wildignore+=*~
set wildignore+=.hg,.git,.svn                        " Version control
set wildignore+=*.aux,*.out,*.toc                    " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.xpm " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest     " compiled object files
set wildignore+=*.class,*.a,*.mo,*.pyc               " mode compiled object files
set wildignore+=*.spl                                " compiled spelling word lists
set wildignore+=*.sw?                                " Vim swap files
set wildignore+=*.DS_Store                           " OSX bullshit
set wildignore+=*.luac                               " Lua byte code
set wildignore+=node_modules/**                      " locally installed NodeJS modules
set wildignore+=tmp/**                               " temporary files

set gdefault " When on, the ":substitute" flag 'g' is default on.
set nosm " don't change to matching braces
set visualbell " instead of emitting an obnoxious noise, the window will flash very briefly
set number " show line numbers
set showtabline=2 " Always show tabline
set fdm=marker
set scrolloff=5 " keep 5 lines below cursor when scrolling
set sidescrolloff=5 " keep 5 columns when scrolling horizontaly
set showcmd " display incomplete commands
set title " show title in console title bar
set mousehide " hide the mouse pointer while typing
set lazyredraw " Speed up macros
set ttyfast " smoother changes
set laststatus=2 " always show status line
set smarttab " sw at the start of the line, sts everywhere else
" Using airline plugin now
" set statusline=
" set statusline+=%2*%-3.3n%0*\                " buffer number
" set statusline+=%f\                          " file name
" set statusline+=%h%1*%m%r%w%0*               " flags
" set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
" set statusline+=%{&encoding},                " encoding
" set statusline+=%{&fileformat}]              " file format
" set statusline+=%=                           " right align
" set statusline+=%2*0x%-8B\                   " current char
" set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset
"set statusline+=\ %t\ \|\ len:\ \%L\ \|\ type:\ %Y\ \|\ ascii:\ \%03.3b\ \|\ hex:\ %2.2B\ \|\ line:\ \%2l
"set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set noruler " it won't be shown anyway because of the statusline
set nosmartindent " smartindent automatically inserts one extra level of indentation in some cases, and works for C-like files
set nocindent " is more customizable, but also more strict when it comes to syntax
set autoindent " copy the indentation from the previous line, when starting a new line
set cpo+=I " when moving the cursor up or down just after inserting indent for 'autoindent', do not delete the indent
set backspace=indent,eol,start   " allow backspacing over everything in insert mode
set nowrap                       " don't wrap lines longer than the screen
set nostartofline                " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]    " move freely between files

set timeoutlen=1200         " A little bit more time for macros
set ttimeoutlen=50          " Make Esc work faster

" # Search
set incsearch    " do incremental searching
set nohlsearch   " do not highlight searches
set ignorecase   " These two options, when set together, will make /-style searches case-sensitive only if there is a capital letter
set smartcase    " in the search expression. *-style searches continue to be consistently case-sensitive

" # Backup
set backupdir=~/.backup          " save all backups in one directory
set directory=~/.backup          " put swaps files here too
set nobackup                     " don't make a name~ backup file after saving file
set updatecount=50               " write swap files to disk after 50 keystrokes
set sessionoptions+=resize,blank " remember empty files and window sizes between sessions

" When pasting from outside vim it turns off auto indentation.
" You can tell you are in paste mode when the ruler is not visible.
set pastetoggle=<F8>

" }}}

" Mappings {{{

let mapleader=","
let g:mapleader=","

" Reformatting a paragraph.
map Q gq

" So that 'a will jump to the line *and* column.
nnoremap ' `
nnoremap ` '

" Fast write, write and quit and quit without save.
nmap ,x :x<CR>
nmap ,w :w<CR>
nmap ,q :q!<CR>

" Use <,,> when in normal mode to write the current buffer.
nnoremap <leader><leader> <C-^>

" Open folder of current file in a new tab.
" %% will be the folder of the currently opened buffer.
cnoremap %% <C-R>=expand('%:h').'/'<CR>
map <leader>e :tabe %%<CR>

" sudo write and quit
cmap x!! w !sudo tee %<CR><CR>:q!<CR>

" map semicolon to colon
nnoremap ; :

" Speeding up viewport scrolling.
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" Hold down the shift key to scroll left and right through the tabs with 'h' and 'l'.
map <S-h> gT
map <S-l> gt

" Insert < => > with Ctrl+l.
imap <c-l> <space>=><space>

" filter non-printable characters from the paste buffer
" useful when pasting from some gui application
nmap <leader>p :let @* = substitute(@*,'[^[:print:]]','','g')<cr>"*p

" Make shift-insert work like in Xterm.
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Press Ctrl+h to toggle highlighting on/off.
noremap <C-h> :set hls!<CR>

" Indent/outdent current block...
nmap <leader>% $>i}``
nmap <leader>$ $<i}``

iabbrev Lipsum Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum

" }}}

" Functions {{{

function! Spaces2()
  " Shows TABs
  set list lcs=tab:>·
  set expandtab
  set softtabstop=2
  set tabstop=2
  set shiftwidth=2
endfunction

function! Spaces4()
  " Shows TABs
  set list lcs=tab:>·
  set expandtab
  set softtabstop=4
  set tabstop=4
  set shiftwidth=4
endfunction

function! Tabs4()
  set nolist
  set noexpandtab
  set softtabstop=4
  set tabstop=4
  set shiftwidth=4
endfunction

" }}}

" Ack
nnoremap <leader>a :Ack
" Rotating among results in an ack search
map <C-n> :cn<CR>
map <C-p> :cp<CR>

" FZF
noremap <leader>t :Files<CR>
map <leader>gf :Files %%<cr>

augroup vimrc_autocmds
  " remove the previous autocmds
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"zz" |
    \ endif

  " Highlight all characters past 100 column
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd BufEnter * match OverLength /\%100v.*/

  " automatically strip trailing whitespace on save
  autocmd BufWritePre * :%s/\s*$//|''

  " Prettier
  " autocmd FileType javascript.jsx,javascript setlocal formatprg=prettier\ --stdin\ --parser\ flow\ --single-quote\ --no-semi\ --trailing-comma\ es5\ --print-width\ 100
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html PrettierAsync
augroup END

" Full text search
" Search in project `:grep <pattern> <files>`
" Enter: Opens first result
" :copen: Opens quick access window
" :cn: Select next
" :cp: Select prev
" :cclose: Close Quick access window

" By default indent with 2 spaces
call Spaces2()

colorscheme onedark
" vim `git grep --name-only name`
