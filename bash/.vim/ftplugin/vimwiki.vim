setlocal wrap             " lines longer than the width of the window will wrap
                          " and displaying continues on the next line.
setlocal textwidth=79     " maximum width of text that is being inserted

autocmd BufNewFile,BufRead,BufWinEnter *.wiki setlocal formatoptions=tcqjmB

" unmap vimwiki's default o and O in normal model
" nnoremap <silent> <buffer> o :<C-U>call vimwiki#lst#kbd_o()<CR>
" nnoremap <silent> <buffer> O :<C-U>call vimwiki#lst#kbd_O()<CR>
nunmap <buffer> o
nunmap <buffer> O
