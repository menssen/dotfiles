" Use zsh
set shell=zsh

" set timeouts to get to normal mode faster
set timeoutlen=1000 ttimeoutlen=0

" Disable silly vi-compatibility
set nocompatible

" Turn off the MacVim toolbar
if has("gui_running")
    set guioptions=-t
endif

" Enable filetype plugins
filetype plugin indent on

" Make all text files markdown
autocmd BufNewFile,BufRead *.{txt,text} set filetype=markdown

set termguicolors
syntax enable

" Kill some security exploits and also modelines are a dumb idea
set modelines=0

" Keep a really long command/search history
set history=1000

" Don't write any backup or swap files ever.
" They're more annoying than they are safe.
set noswapfile
set nowritebackup
set nobackup

" Allow open buffers that are not visible
set hidden

" All other encodings are bad
set encoding=utf-8

" Force showing three extra lines above and below cursor (so you're never
" typing on the last line of the window)
set scrolloff=3

" Turn on auto-indentation, for better or worse
set autoindent

" Do not beep.
set visualbell

" Highlight the line the cursor is in
set cursorline

" Enable mouse support in terminals that can handle it
set mouse=a

" Make backspace also delete indents and line endings
set backspace=indent,eol,start

" Always show the status line above the command line
set laststatus=2

" Show the cursor position at the end of the status line
set ruler

" Show tidbits of info in bottom right about current keyboard command
set showcmd

" Make tab completion a lot smarter (this mostly makes it work like zsh)
set wildmenu
set wildmode=longest,list

" Turn off vim-mode regexes because nobody knows how they work
" nnoremap / /\v
" vnoremap / /\v

" Searches should be case insensitive unless there is a capital letter
set ignorecase
set smartcase

" Adds the /g option to replace all occurences by default instead
" of just the first.  Using /g turns this off.
set gdefault

" Make searches perform/highlight automatically while you type
set incsearch
set showmatch
set hlsearch

" Display a colored column at 81 characters
" (This means text appearing on top of the line is BAD)
set colorcolumn=81

" Don't wrap text, but add characters indicating hidden parts of a line
" and change horizontal scrolling to be sane
set nowrap
set sidescroll=1
set sidescrolloff=1
set listchars=extends:>,precedes:<

" But wrap text for txt/markdown
autocmd FileType markdown set wrap linebreak textwidth=0
autocmd FileType txt set wrap linebreak textwidth=0

" If wrapping is enabled, mark wrapped lines
set showbreak=\ ->\ 

" But not for txt/markdown
autocmd FileType markdown set showbreak=
autocmd FileType txt set showbreak=

" Shrink inactive splits to 10 rows and 20 cols
set winwidth=10
set winminwidth=10
set winwidth=120


" CUSTOM KEY BINDINGS

" Change the leader key to comma
let mapleader = ","

" Use old indent guides keymappings for IndentBlankline
nmap <Leader>ig :IndentBlanklineToggle<cr>

" Use leader prefixed y/p for system clipboard
vmap <Leader>y "*y
vmap <Leader>d "*d
nmap <Leader>p "*p
nmap <Leader>P "*P
vmap <Leader>p "*p
vmap <Leader>P "*P

" Jump to end of selection after pasting
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Use leader-s to automatically enter search-and-replace when in visual
vnoremap <leader>s :s/\v

" Clear highlighted search
nnoremap <space> :noh<cr>

" Shortcuts for creating vertical splits
" Had a horizontal one in here but never used it
nnoremap <leader>v <C-w>v<C-w>l<C-w>L

" Easier split navigation
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Map ctrl-f to Telescope because I'm used to it
nmap <c-f> :Telescope find_files<cr>

" More telescope maps
nmap <Leader>ff :Telescope buffers<cr>
nmap <Leader>fg :Telescope live_grep<cr>
nmap <Leader>f. :Telescope builtin<cr>

" Use ag for grep
set grepprg=ag\ --nogroup\ --nocolor

" Map <leader><leader> to switch to last buffer
nnoremap <leader><leader> <c-^>

" Add a blank line below in normal mode, stay in normal mode
nnoremap <c-o> o<esc>

" Make scroll up/down scroll faster
noremap <c-e> 5<c-e>
noremap <c-y> 5<c-y>

" Turn on and off textwrap
nnoremap <leader>w :set nowrap!<cr>

" Map ,t to tidy up files based on file type
autocmd BufNewFile,BufRead *.{json} nnoremap <leader>y :%!python3 -mjson.tool<cr>
autocmd BufNewFile,BufRead *.{xml} nnoremap <leader>y :%!xmllint --format -<cr>

set expandtab
set shiftwidth=2
set softtabstop=2

" Rename Current File
" (Stolen from Gary Bernhardt)
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" Use Tab for indent if on a blank/whitespace line,
" or completion if there is text entered
" (Stolen from Gary Benhardt)
" function! InsertTabWrapper()
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] =~ '\s'
"         return "\<tab>"
"     else
"         g:deoplete#manual_complete()
"     endif
" endfunction
" inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" inoremap <s-tab> <c-n>

" Files should open with cursor at same line as when closed
" From vim docs, via Gary Bernhardt
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif


