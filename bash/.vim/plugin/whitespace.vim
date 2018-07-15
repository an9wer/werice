" Vim global plugin for executing whitespace
" Last Change:  2018 Jul 15
" Maintainer:   an9wer <an9wer@gmail.com>
" License:      This file is placed in the public domain

if exists('g:load_whitespace')
  finish
endif
let g:load_whitespace = 1

let s:cpo_save = &cpo
set cpo&vim

" you may need to see :h *sub-replace-\=

let s:trailing_space_pattern = '\s\+$'
let s:begining_tab_pattern = '^\t\+'
let s:duplicate_space_pattern = ' \{2,}'

command SearchTrailingSpace
  \ let @/ = s:trailing_space_pattern | normal n
command SearchBeginingTab
  \ let @/ = s:begining_tab_pattern | normal n
command SearchDuplicateSpace
  \ let @/ = s:duplicate_space_pattern | normal n

command -range=% RemoveTrailingSpace
  \ let @/ = s:trailing_space_pattern | <line1>,<line2>s///
command -range=% ReplaceBeginingTab
  \ let @/ = s:begining_tab_pattern | <line1>,<line2>s///
command -range=% TruncateDuplicateSpace
  \ let @/ = s:duplicate_space_pattern | <line1>,<line2>s// /g

let &cpo = s:cpo_save
unlet s:cpo_save
