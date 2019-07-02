setlocal wrap             " lines longer than the width of the window will wrap
                          " and displaying continues on the next line.
setlocal textwidth=79     " maximum width of text that is being inserted

augroup ftplugin_rst
  au!
  " Q: set formatoptions doesn't work?
  " A: https://stackoverflow.com/a/24170442
  autocmd BufWinEnter *.rst     setlocal formatoptions=tcqjmB
augroup END
