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


" equal abbreviate
inoreabbrev <buffer> 1=
  \ <C-R>=<SID>VimwikiHeader(1)<CR><C-R>=<SID>VimwikiHeaderCursor(1)<CR>
inoreabbrev <buffer> 2=
  \ <C-R>=<SID>VimwikiHeader(2)<CR><C-R>=<SID>VimwikiHeaderCursor(2)<CR>
inoreabbrev <buffer> 3=
  \ <C-R>=<SID>VimwikiHeader(3)<CR><C-R>=<SID>VimwikiHeaderCursor(3)<CR>
inoreabbrev <buffer> 4=
  \ <C-R>=<SID>VimwikiHeader(4)<CR><C-R>=<SID>VimwikiHeaderCursor(4)<CR>
inoreabbrev <buffer> 5=
  \ <C-R>=<SID>VimwikiHeader(5)<CR><C-R>=<SID>VimwikiHeaderCursor(5)<CR>
inoreabbrev <buffer> 6=
  \ <C-R>=<SID>VimwikiHeader(6)<CR><C-R>=<SID>VimwikiHeaderCursor(6)<CR>

if exists('g:load_ftplugin_vimwiki')
  finish
endif
let g:load_ftplugin_vimwiki = 1

function s:VimwikiHeader(level)
  let l:lcont = getline('.')
  if l:lcont =~ '^$'
    return repeat('=', a:level) . '  ' . repeat('=', a:level)
  else
    if getcurpos()[2] == 1
      normal! cc
      return repeat('=', a:level) . ' ' . l:lcont . ' ' . repeat('=', a:level)
    else
      return a:level . '='
endfunction

function s:VimwikiHeaderCursor(level)
  let l:lcont = getline('.')
  let l:start = strlen(l:lcont) - a:level - 1
  let l:col = match(l:lcont, ' ' . repeat('=', a:level), l:start)
  if l:col != -1
    execute('normal! ' . (l:col+1) . '|')
  endif
  return ''
endfunction
