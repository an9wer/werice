setlocal wrap             " lines longer than the width of the window will wrap
                          " and displaying continues on the next line.
setlocal textwidth=79     " maximum width of text that is being inserted

augroup ftplugin_vimwiki
  au!

  " Q: set formatoptions doesn't work?
  " thx: https://stackoverflow.com/a/24170442
  autocmd BufWinEnter *.wiki setlocal formatoptions=tcqjmB

  " unmap vimwiki's default o and O in normal model
  " nnoremap <silent> <buffer> o :<C-U>call vimwiki#lst#kbd_o()<CR>
  " nnoremap <silent> <buffer> O :<C-U>call vimwiki#lst#kbd_O()<CR>
  autocmd BufWinEnter *.wiki
    \ if !empty(maparg('o', 'n')) |
    \   nunmap <buffer> o|
    \ endif
  autocmd BufWinEnter *.wiki
    \ if !empty(maparg('O', 'n')) |
    \   nunmap <buffer> O|
    \ endif
augroup END

inoreabbrev <buffer>  = <C-R>=execute('VimwikiHeader 1')<CR>
inoreabbrev <buffer> 1= <C-R>=execute('VimwikiHeader 1')<CR>
inoreabbrev <buffer> 2= <C-R>=execute('VimwikiHeader 2')<CR>
inoreabbrev <buffer> 3= <C-R>=execute('VimwikiHeader 3')<CR>
inoreabbrev <buffer> 4= <C-R>=execute('VimwikiHeader 4')<CR>
inoreabbrev <buffer> 5= <C-R>=execute('VimwikiHeader 5')<CR>
inoreabbrev <buffer> 6= <C-R>=execute('VimwikiHeader 6')<CR>

" TODO: Fix problem which 'asdf 5=' will be convert to 'asdf 5 ='
" use normal command '|' to move to first column in current line (see h: bar)
command -nargs=1 -buffer VimwikiHeader
  \ let times = <args> |
  \ if getline('.') =~ '^$' |
  \   let insert_cmd = 'normal! i' . repeat('=', times) . '  ' . repeat('=', times) |
  \   call execute(insert_cmd) |
  \   let times += 2 |
  \   let cursor_cmd = 'normal! ' . times . '|' |
  \   call execute(cursor_cmd) |
  \ else |
  \   let insert_cmd = 'normal! i<C-u>' . getline('.') . times . '=' |
  \   call execute(insert_cmd) |
  \ endif |
  \ unlet! times insert_cmd cursor_cmd
