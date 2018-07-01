" vim bundle manager and config
" Last Change:  2018 Jul 1
" Maintainer:   an9wer <an9wer@gmail.com>
" License:      This file is placed in the public domain

" TODO: running asynchronously

if exists('g:loaded_bundle')
  finish
endif
let g:loaded_bundle = 1

let s:cpo_save = &cpo
set cpo&vim

nnoremap <Leader>bi :<C-U>call Bundle("install")<CR>
nnoremap <Leader>bu :<C-U>call Bundle("update")<CR>
nnoremap <Leader>br :<C-U>call Bundle("remove")<CR>


let s:bundle_buf_name = "__Bundle__"
let s:self_dir_path = expand("<sfile>:p:h")
let s:bundle_dir_path = simplify(s:self_dir_path . "/../bundle")
let s:plugins = [
  \   "yonchu/accelerated-smooth-scroll",
  \   "inkarkat/vim-ingo-library",
  \   "inkarkat/vim-SearchHighlighting",
  \   "scrooloose/nerdtree",
  \   "junegunn/fzf.vim",
  \   "vimwiki/vimwiki",
  \   "sjl/gundo.vim",
  \ ]


function s:BundlePluginPath(plugin)
  return s:bundle_dir_path . "/" .split(a:plugin, "/")[-1]
endfunction


function s:BundleWindowOpen()
  " create bundle window if not present
  if bufnr(s:bundle_buf_name) == -1
    execute "botright " . (len(s:plugins) + 2) . "new " . s:bundle_buf_name
  endif
  if bufwinnr(s:bundle_buf_name) == -1
    execute "botright " . (len(s:plugins) + 2) . "new " . s:bundle_buf_name
  endif
endfunction


function s:BundleWindowGoto()
  " move cursor to the bundle window
  execute bufwinnr(s:bundle_buf_name) . "wincmd w"
  call cursor(1, 1)
endfunction


function s:BundleWindowRender(event)
  setlocal modifiable
  call setline(1, a:event)
  call setline(2, repeat('-', 79))
  call setline(3, s:plugins)
  setlocal nomodifiable
  redraw
endfunction


function s:BundleWindowSetting()
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal nobuflisted
  setlocal nomodifiable
  setlocal filetype=diff
  setlocal nonumber
  setlocal norelativenumber
  setlocal nowrap
  setlocal foldlevel=20
  setlocal foldmethod=diff
endfunction


function s:BundleExe(plugin, cmd)
  setlocal modifiable
  call setline(search(a:plugin), a:plugin . "  doing")
  setlocal nomodifiable
  redraw

  call system(a:cmd)

  setlocal modifiable
  call setline(search(a:plugin), a:plugin . "  done")
  setlocal nomodifiable
  redraw
endfunction


function Bundle(event)
  call s:BundleWindowOpen()
  call s:BundleWindowGoto()
  call s:BundleWindowSetting()
  call s:BundleWindowRender(a:event)

  for l:plugin in s:plugins
    if a:event == "install"
      let l:cmd = "git clone --depth 1 https://github.com/" . l:plugin . ".git "
        \ . <SID>BundlePluginPath(l:plugin)
    elseif a:event == "update"
      let l:cmd = "cd " . <SID>BundlePluginPath(l:plugin) .
        \ " && git pull origin master"
    elseif a:event == "remove"
      let l:cmd = "rm -rf " . <SID>BundlePluginPath(l:plugin)
    else
      return -1
    endif
    call s:BundleExe(l:plugin, l:cmd)
  endfor

endfunction


let &cpo = s:cpo_save
unlet s:cpo_save
