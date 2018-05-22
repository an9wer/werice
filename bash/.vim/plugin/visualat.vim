if exists('g:loaded_visualat')
  finish
endif
let g:loaded_visualat = 1

let s:cpo_save = &cpo
set cpo&vim

xnoremap @ :<C-u>call <SID>ExecuteMacroOverVisualRange()<CR>

function! s:ExecuteMacroOverVisualRange() abort
  echo "@"
  execute "'<,'>normal @" . nr2char(getchar())
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
