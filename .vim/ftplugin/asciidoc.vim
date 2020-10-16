setlocal wrap             " lines longer than the width of the window will wrap
                          " and displaying continues on the next line.
setlocal textwidth=79     " maximum width of text that is being inserted

augroup ftplugin_asciidoc
  au!
  " Q: set formatoptions doesn't work?
  " thx: https://stackoverflow.com/a/24170442
  autocmd BufWinEnter *.adoc     setlocal formatoptions=tcqjmB
  autocmd BufWinEnter *.asciidoc setlocal formatoptions=tcqjmB
augroup END
