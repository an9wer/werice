" runtimepath
" -----------------------------------------------------------------------------
execute pathogen#infect()

" NERDTree
" -----------------------------------------------------------------------------
"set runtimepath^=~/.vim/bundle/NERDTreeToggle
map <F2> :NERDTreeToggle<CR>


" fzf
" -----------------------------------------------------------------------------
" if fzf is installed using git
if !empty(glob("~/.me/lib/fzf"))
  set runtimepath+=~/.me/lib/fzf
endif

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Q: let fzf ignore some files
" thx: https://github.com/junegunn/fzf#respecting-gitignore
" let $FZF_DEFAULT_COMMAND="find -L . ! -name '*.pyc'"
" let $FZF_DEFAULT_OPTS="--height 100% --preview 'cat {}' --bind alt-j:preview-down,alt-k:preview-up,alt-b:preview-page-up,alt-f:preview-page-down"


" options
" -----------------------------------------------------------------------------
"unlet! skip_defaults_vim
"source $VIMRUNTIME/defaults.vim

set nocompatible        " use Vim defaults instead of 100% vi compatibility

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on
endif

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
" Revert with ":filetype off".
filetype plugin indent on

set hlsearch            " highlighting search matches
set backspace=indent,eol,start  " allow backspacing over everything
                                " in insert mode

set history=50          " keep 50 lines of command line history
set ruler               " show the line and column number of the cursor
                        " position, separated by a comma

" you may need to see ':h retab' when you want to change all tab in some file.
set tabstop=4           " number of spaces that a <Tab> in the file counts for
set shiftwidth=4        " number of spaces to use for each step of (auto)indent
set expandtab           " replace <Tab> with appropriate number of sapce
set autoindent          " automatically copy indent from current line when
                        " starting a new line

" Q: delay when pressing <SHIFT> + o after pressing <ESC>
" thx: https://stackoverflow.com/a/2158610
" thx: https://github.com/vim/vim/issues/24
" also check termcap document to find help (:h termcap).
set notimeout           " don't timeout on mappings
set ttimeout            " do timeout on terminal key codes
set timeoutlen=100      " timeout after 100 msec

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,
set suffixes+=.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" modelines have historically been a source of security/resource
" vulnerabilities -- disable by default, even when 'nocompatible' is set
set nomodeline

set number              " print the line number in front of each line.
set relativenumber      " show the line number relative to the line with
                        " the cursor in front of each line
set numberwidth=5       " minimal number of columns to use for the line number

set colorcolumn=80      " a comma separated list of screen columns
