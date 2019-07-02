" Vim global plugin for tabline
" Last Change:  2019 Jul 02
" Maintainer:   an9wer <an9wer@gmail.com>
" License:      MIT


if exists('g:loaded_tabline')
  finish
endif
let g:loaded_tabline = 1

let s:cpo_save = &cpo
set cpo&vim


function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    " If <bufname> is a directory, then keep its slash (/).
    let s .= (bufname != '' ? '[' . fnamemodify(bufname, ':p:s?/.\+/\(.\+\)$?\1?') . '] ' : '[No Name] ')

    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  if (exists("g:tablineclosebutton"))
    let s .= '%=%999XX'
  endif
  return s
endfunction

set tabline=%!Tabline()


let &cpo = s:cpo_save
unlet s:cpo_save
