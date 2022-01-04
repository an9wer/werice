set runtimepath^=~/.vim/bundle/vim-system-copy

" vim-system-copy
" -----------------------------------------------------------------------------
let g:system_copy#copy_command='xclip -sel clipboard -r'
let g:system_copy#paste_command='xclip -sel clipboard -o'


" netrw
" -----------------------------------------------------------------------------
let g:netrw_keepdir = 0


" options
" -----------------------------------------------------------------------------
" use Vim defaults instead of 100% vi compatibility
set nocompatible

" Print the line number in front of each line
set number

" A comma separated list of screen columns
set colorcolumn=80

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=5

" Change the current working directory whenever you open a file, switch
" buffers, delete a buffer or open/close a window
set autochdir

" List of directory names for the swap file
set directory=~/.vim/swap

" Enable filetype detection
filetype on

" Enable loading filetype plugin
filetype plugin on


" Abbreviation (see :h abbreviation)
" -----------------------------------------------------------------------------
iabbrev <expr> dt  strftime("%Y/%m/%d")
iabbrev <expr> dtw strftime("%Y/%m/%d %a")


" Commonly misspelled words
" -----------------------------------------------------------------------------
iabbrev teh the
iabbrev hte the


" Color
" -----------------------------------------------------------------------------
" Tab bar
highlight TabLineFill ctermfg=DarkGray
highlight TabLine ctermbg=Gray ctermfg=Black
highlight TabLineSel ctermbg=DarkBlue ctermfg=White

" Matched parenthesis
highlight MatchParen ctermbg=DarkGray

" Status line
highlight StatusLine ctermfg=DarkGreen
