" Vim global plugin for saving and reading undofile
" Last Change:  2018 May 25
" Maintainer:   an9wer <an9wer@gmail.com>
" License:      This file is placed in the public domain

if exists('g:loaded_undofile')
  finish
endif
let g:loaded_undofile = 1

let s:cpo_save = &cpo
set cpo&vim

" ensure to keep 'undofile' off, otherwise you end up with two undo files for
" every write.
set noundofile

autocmd BufReadPost * silent call <SID>ReadUndo()
autocmd BufWritePost * silent call <SID>WriteUndo()

command GetUndoFilePath echo <SID>GetUndoFilePath()

let s:undo_path = $HOME . "/.vim/undo"
if !isdirectory(s:undo_path)
  call mkdir(s:undo_path, 'p')
endif

function s:GetUndoFilePath()
  let l:file = expand("%:p")
  let l:sha1 = system("echo " . l:file . " | " . "sha1sum")
  return s:undo_path . "/" . strpart(l:sha1, 0, 2) . "/" . strpart(l:sha1, 2, 38)
endfunction

function s:ReadUndo() abort
  let l:undo_path = s:GetUndoFilePath()
  if filereadable(l:undo_path)
    " see :h {file}
    rundo `=l:undo_path`
  endif
endfunction

function s:WriteUndo() abort
  let l:undo_path = s:GetUndoFilePath()
  let l:undo_path_head = fnamemodify(l:undo_path, ':h')
  if !isdirectory(l:undo_path_head)
    call mkdir(l:undo_path_head, 'p')
  endif
  " see :h {file}
  wundo `=l:undo_path`
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
