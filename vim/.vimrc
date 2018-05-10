" runtimepath
" -----------------------------------------------------------------------------
execute pathogen#infect()

" NERDTree
" -----------------------------------------------------------------------------
"set runtimepath^=~/.vim/bundle/NERDTreeToggle
map <F2> :NERDTreeToggle<CR>



" options
" -----------------------------------------------------------------------------
set nocompatible        " use Vim defaults instead of 100% vi compatibility

set hlsearch            " highlighting search matches
set backspace=indent,eol,start  " allow backspacing over everything in insert mode

set history=50          " keep 50 lines of command line history
set ruler               " show the line and column number of the cursor position, separated by a comma

" you may need to see ':h retab' when you want to change all tab in some file.
set tabstop=4           " number of spaces that a <Tab> in the file counts for
set shiftwidth=4        " number of spaces to use for each step of (auto)indent
set expandtab           " replace <Tab> with appropriate number of sapce
set autoindent          " automatically copy indent from current line when starting a new line

" Q: delay when pressing <SHIFT> + o after pressing <ESC>
" thx: https://stackoverflow.com/a/2158610
" thx: https://github.com/vim/vim/issues/24
" also check termcap document to find help. (:h termcap)
set notimeout           " don't timeout on mappings
set ttimeout            " do timeout on terminal key codes
set timeoutlen=100      " timeout after 100 msec

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" modelines have historically been a source of security/resource
" vulnerabilities -- disable by default, even when 'nocompatible' is set
set nomodeline

set number              " print the line number in front of each line.
set relativenumber      " show the line number relative to the line with the cursor in front of each line
set numberwidth=5       " minimal number of columns to use for the line number
