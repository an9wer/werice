" vim bundle manager and config
" Last Change:  2018 Jun 29
" Maintainer:   an9wer <an9wer@gmail.com>
" License:      This file is placed in the public domain

" TODO: quickfix

if exists('g:loaded_bundle')
  finish
endif
let g:loaded_bundle = 1

let s:cpo_save = &cpo
set cpo&vim

let s:self_dir_path = expand("<sfile>:p:h")
let s:bundle_dir_path = '/tmp'
let s:plugins = [
  \   "yonchu/accelerated-smooth-scroll",
  \   "inkarkat/vim-ingo-library",
  \   "inkarkat/vim-SearchHighlighting",
  \   "scrooloose/nerdtree",
  \   "junegunn/fzf.vim",
  \   "vimwiki/vimwiki",
  \   "sjl/gundo.vim",
  \ ]

function BundleInstall()
  function BundleInstallOutHandler(channel, msg)
    echo a:msg
  endfunction

  function BundleInstallErrHandler(channel, msg)
    echoe a:msg
  endfunction

  function BundleInstallCloseHandler(channel)
    echo "installation is done"
  endfunction

  for l:plugin in s:plugins
    let l:cmd = ["/bin/bash", "-c"]
    let l:cmd += [
      \ "git clone --depth 1 https://github.com/" . l:plugin . ".git " .
      \ <SID>BundlePluginPath(l:plugin)]
    echo l:cmd
    " call system(l:cmd)
    let l:job = job_start(l:cmd, {
      \   "out_cb": "BundleInstallOutHandler",
      \   "err_cb": "BundleInstallErrHandler",
      \   "close_cb": "BundleInstallCloseHandler",
      \ })
  endfor
endfunction

function BundleUpdate()
  function BundleUpdateOutHandler(channel, msg)
    echo a:msg
  endfunction

  function BundleUpdateErrHandler(channel, msg)
    echoe a:msg
  endfunction

  function BundleUpdateCloseHandler(channel)
    echo "update is done"
  endfunction

  for l:plugin in s:plugins
    let l:cmd = ["/bin/bash", "-c"]
    let l:cmd += [
      \ "cd " . <SID>BundlePluginPath(l:plugin) . " && git pull origin master"]

    echo l:cmd
    let l:job = job_start(l:cmd, {
      \   "out_cb": "BundleUpdateOutHandler",
      \   "err_cb": "BundleUpdateErrHandler",
      \   "close_cb": "BundleUpdateCloseHandler",
      \ })
  endfor
endfunction

function BundleRemove(...)
  let l:plugins = a:0 == 0 ? s:plugins : a:000
  for l:plugin in l:plugins
    if match(s:plugins, l:plugin) != -1
      let l:cmd = ["/bin/bash", "-c"]
      let l:cmd += ["rm -rf " . <SID>BundlePluginPath(l:plugin)]
      echo l:cmd
      " TODO: job_start()
    else
      echoerr "plugin '" l:plugin . "' doesn't exist"
    endif
  endfor
endfunction

function s:BundlePluginPath(plugin)
  return s:bundle_dir_path . "/" .split(a:plugin, "/")[-1]
endfunction


let &cpo = s:cpo_save
unlet s:cpo_save
