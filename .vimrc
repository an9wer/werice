set runtimepath^=~/.vim/bundle/vim-system-copy

" vim-system-copy
" -----------------------------------------------------------------------------
let g:system_copy#copy_command='xclip -sel clipboard -r'
let g:system_copy#paste_command='xclip -sel clipboard -o'


" netrw
" -----------------------------------------------------------------------------
"let g:netrw_keepdir = 0


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

" List of directories for the swap file
set directory=~/.vim/swap

" Keycode delay time (which is required for mapping alt key below)
set ttimeoutlen=50

" Enable loading filetype plugin
filetype plugin on


" Abbreviation (see `:h abbreviation`)
" -----------------------------------------------------------------------------
iabbrev <expr> dt  strftime("%Y/%m/%d")
iabbrev <expr> dtw strftime("%Y/%m/%d %a")


" Commonly misspelled words
" -----------------------------------------------------------------------------
iabbrev teh the
iabbrev hte the


" Set new keycode for some key or override keycode from termcap/terminfo
" (see `:h set-termcap` and `:h map-alt-keys`)
" -----------------------------------------------------------------------------
set <M-b>=b
set <M-f>=f


" Key maps in command line mode
" -----------------------------------------------------------------------------
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>


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
