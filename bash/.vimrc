" runtimepath
" -----------------------------------------------------------------------------
if empty(glob("~/.vim/autoload/pathogen.vim"))  "download pathogen.vim
  sil exe "!curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim"
endif
execute pathogen#infect()

let g:gundo_prefer_python3 = 1
nnoremap <F5> :GundoToggle<CR>

" NERDTree
" -----------------------------------------------------------------------------
map <F2> :NERDTreeToggleOrFind<CR>
command! NERDTreeToggleOrFind call <SID>NERDTreeToggleOrFind()

function! s:NERDTreeToggleOrFind()
  if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
    execute ":NERDTreeClose"
  else
    if expand("%:t") != '' && glob("%") != ''
      execute ":NERDTreeFind"
    else
      execute ":NERDTreeToggle"
    endif
  endif
endfunction


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


" vimwiki
" -----------------------------------------------------------------------------
let g:vimwiki_list =
  \ [{'path': '~/Documents/notes', 'path_html': '~/Documents/notes_html'}]

"let g:vimwiki_folding = 'list'

" vimwiki header color
highlight VimwikiHeader1 ctermfg=Black ctermbg=DarkRed
highlight VimwikiHeader2 ctermfg=Black ctermbg=DarkGreen
highlight VimwikiHeader3 ctermfg=Black ctermbg=DarkBlue
highlight VimwikiHeader4 ctermfg=Black ctermbg=DarkMagenta
highlight VimwikiHeader5 ctermfg=Black ctermbg=DarkYellow
highlight VimwikiHeader6 ctermfg=Black ctermbg=DarkCyan


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
set showcmd             " show (partial) command in the last line of the screen,
                        " set this option off if your terminal is slow
set ruler               " show the line and column number of the cursor
                        " position, separated by a comma

" you may need to use :retab when you want to change all tab in some file.
set tabstop=4           " number of spaces that a <Tab> in the file counts for
set shiftwidth=4        " number of spaces to use for each step of (auto)indent
set expandtab           " replace <Tab> with appropriate number of sapce
set autoindent          " automatically copy indent from current line when
                        " starting a new line

set wrap                " lines longer than the width of the window will wrap
                        " and displaying continues on the next line.
set textwidth=0         " maximum width of text that is being inserted
" Q: set formatoptions=qj doesn't work
" thx: https://stackoverflow.com/a/24170442
autocmd BufWinEnter * setlocal formatoptions=qj

" Q: delay when pressing <SHIFT> + o after pressing <ESC>
" thx: https://github.com/vim/vim/issues/24
" also check termcap document to find help (:h termcap).
set notimeout           " do not timeout on mappings
set ttimeout            " do timeout on terminal key codes
set ttimeoutlen=100     " wait up to 100ms after Esc for special key


" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,
set suffixes+=.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" modelines have historically been a source of security/resource
" vulnerabilities -- disable by default, even when 'nocompatible' is set
" set nomodeline

set number              " print the line number in front of each line
set relativenumber      " show the line number relative to the line with
                        " the cursor in front of each line
set numberwidth=5       " minimal number of columns to use for the line number

set colorcolumn=80      " a comma separated list of screen columns

set hidden

" key map (see h: key-notation)
" -----------------------------------------------------------------------------

" fix meta-keys <M-A> ... <M-Z> which generate <Esc>a ... <Esc>z
" thx: http://vim.wikia.com/wiki/VimTip738
" thx: https://stackoverflow.com/a/10216459
" thx: http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal
let s:alpha = 'a'
while s:alpha <= 'z'
  execute "set <M-" . toupper(s:alpha) . ">=\e" . s:alpha
  "execute "imap \e" . s:alpha . " <M-" . toupper(s:alpha) . ">"
  let s:alpha = nr2char(1+char2nr(s:alpha))
endwhile
unlet s:alpha

" redefine commandline editing key (see h: cmdline-editing)
" move cursor to the begining/end
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
" move cursor left/right
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
" move cursor one word left/right
cnoremap <M-B> <S-Left>
cnoremap <M-F> <S-Right>

" redefine insert special key (see h: ins-special-key)
" move cursor to the begining/end
inoremap <C-A> <Home>
inoremap <C-E> <End>
" move cursor left/right
inoremap <C-B> <Left>
inoremap <C-F> <Right>
" move cursor one word left/right
inoremap <M-B> <S-Left>
inoremap <M-F> <S-Right>


" color
" -----------------------------------------------------------------------------
" tab bar
highlight TabLineFill ctermfg=DarkGray
highlight TabLine ctermbg=Gray
highlight TabLineSel ctermbg=DarkBlue


" load customized config
" -----------------------------------------------------------------------------
packadd! config   " The extra '!' is so that the plugin isn't loaded if Vim was
                  " started with '-noplugin'
