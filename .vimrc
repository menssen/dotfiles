" All required plugins are submodules of this git repository
"
" Be sure to install Solarized terminal color scheme
"
" Define :Bclose to close a buffer without closing a window using
" the first script on
" http://vim.wikia.com/wiki/Deleting_a_buffer_without_closing_the_window
" and placing it in
" ~/.vim/bundle/bclose/plugin/bclose.vim
"
" (also checked into this repo)

" Use zsh
set shell=zsh

" Disable silly vi-compatibility
set nocompatible

" Turn off the MacVim toolbar
if has("gui_running")
    set guioptions=-t
endif

" Enable filetype plugins
filetype plugin indent on

" Pathogen Bundle Manager
call pathogen#infect()

" Use ag instead of ack
let g:ackprg = 'ag --vimgrep'

" Make all text files markdown
autocmd BufNewFile,BufRead *.{txt,text} set filetype=markdown

" Enable todo.txt filetype detection
autocmd BufNewFile,BufRead todo.txt set syntax=todo foldmethod=indent

" Function to activate degraded colors for 256 color terminals without
" solarized scheme
function! FixColors()
    if g:solarized_termcolors == 256
        let g:solarized_termcolors = 16
    else
        let g:solarized_termcolors = 256
    endif
    colorscheme solarized
    set background=light
endfunction
command! FixColors call FixColors()

" Colors, solarized theme.  See above for note.
syntax enable
set background=light
colorscheme solarized

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

" Enable mouse support in terminals that can handle it (iTerm can,
" Terminal.app can't)
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
nnoremap / /\v
vnoremap / /\v

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

" Set indent guide colors to sane values for solarized
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=8 guibg=#002b36
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=0 guibg=#073642

" Increase ctrlp file limit from 10,000 to 100,000
let g:ctrlp_max_files = 100000

" CtrlP should ignore dot files
let g:ctrlp_dotfiles = 0

" CtrlP shouldn't remember the last input
let g:ctrlp_persistent_input = 0

" Don't let ctrlp change working directory
let g:ctrlp_working_path_mode = 0

" CtrlP should ignore some files
"
" This is kind of a mess. Better solution?
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](target|build-app|build-web|release-app|release-web|build-phonegap|release-phonegap|node_modules|vendor|app\/cache)$',
    \ }

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Shrink inactive splits to 10 rows and 20 cols
set winwidth=10
set winminwidth=10
set winwidth=120

" Use ag to make CtrlP faster
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'


" CUSTOM KEY BINDINGS

" Change the leader key to comma
let mapleader = " "

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
nnoremap <enter> :noh<cr>

" Force use of hjkl instead of arrows to break bad habits
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Shortcuts for creating vertical splits
" Had a horizontal one in here but never used it
nnoremap <leader>v <C-w>v<C-w>l<C-w>L

" Easier split navigation
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Shortcut to close a buffer without closing the window
nnoremap <silent> <leader>d :Bclose<cr> 

" Set CtrlP map to ctrl-f because it's easier to hit
let g:ctrlp_map = '<c-f>'

" Use ag for grep
set grepprg=ag\ --nogroup\ --nocolor

" Map <leader>f to open CtrlP in buffer mode
nnoremap <silent> <leader>f :CtrlPBuffer<cr>

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
autocmd BufNewFile,BufRead *.{json} nnoremap <leader>y :%!python -mjson.tool<cr>

" Eclim shortcuts
map <leader>jj :JavaSearch<cr>:cc 1<cr>:ccl<cr>
map <leader>js :JavaSearch com.denali.core*
map <leader>ju :JUnit %<cr>

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
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-x>\<c-u>"
      endiff
    endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Files should open with cursor at same line as when closed
" From vim docs, via Gary Bernhardt
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif


