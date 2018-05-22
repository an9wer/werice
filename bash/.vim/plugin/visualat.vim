if exists('g:loaded_visualat')
  finish
endif
let g:loaded_visualat = 1

let s:cpo_save = &cpo
set cpo&vim

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange() abort
  let l:reg = nr2char(getchar())
  let l:str = getreg(l:reg)
  if empty(l:str)
    echohl ErrorMsg | echo "cannot find register '" . l:reg . "'" | echohl None
    return
  endif
  execute "'<,'>normal @" . l:reg
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
