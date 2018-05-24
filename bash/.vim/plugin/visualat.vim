" Vim global plugin for executing contents of register in visual mode
" Last Change:  2018 May 24
" Maintainer:   an9wer <an9wer@gmail.com>
" License:      This file is placed in the public domain.


if exists('g:loaded_visualat')
  finish
endif
let g:loaded_visualat = 1

let s:cpo_save = &cpo
set cpo&vim

xnoremap @ :<C-u>call <SID>ExecuteMacroOverVisualRange()<CR>

function! s:ExecuteMacroOverVisualRange() abort
  let l:reg = nr2char(getchar())
  let l:con = getreg(l:reg)
  if empty(l:con)
    echohl ErrorMsg | echo "cannot find register '" . l:reg . "'" | echohl None
    return
  endif
  execute "'<,'>normal @" . l:reg
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
