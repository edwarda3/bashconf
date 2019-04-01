"VIMRC File by Alex Edwards

"---COLOR SCHEME---
"Good colorschemes: darkblue,ron,slate,zellner,murphy
colo slate

"Syntax highlighting
syntax enable

"---CONFIG STUFF---
"Show vim mode on last line
set showmode

"Enable backups to backupdir folder
"set backup
"set backupdir=~/vimbackups

"---INDENT---
"The number of visual spaces shown when <TAB> is read
set tabstop=4

"The number of spaces inserted or deleted when using <TAB>
set softtabstop=4

"Let <TAB> insert spaces
set expandtab

"The size of a single indent
set shiftwidth=4

"Let the tab round to the nearest multiple of softtabstop in column number
set shiftround

"Use filetype specific indentation file from ~/.vim/indent/<file>.vim
filetype indent on

"Autoindent
set autoindent

"Let <TAB> go to the next indent level when pressing tab at beginning of line
set smarttab

"---Visual Assistance---
"Line numbers
set number

"Highlight where the cursor is
set cursorline

"Highlight matching brackets
set showmatch

"Highlight search
set hlsearch

"Search as characters are entered
set incsearch

"Show visual menu when autocompleting vim commands
set wildmenu

"Enable Folding (Fold current with za, global open zO, global close zC)
set foldenable

"Use indent folding as default
set foldmethod=indent

"The the default level of folding when opening a new buffer
set foldlevelstart=20

"---For TMUX---
"Use vertical line for cursor instead of block when using TMUX
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
