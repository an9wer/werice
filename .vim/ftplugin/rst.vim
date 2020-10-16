setlocal tabstop=4        " number of spaces that a <Tab> in the file counts for
setlocal shiftwidth=4     " number of spaces to use for each step of (auto)indent
setlocal expandtab        " replace <Tab> with appropriate number of sapce
setlocal wrap             " lines longer than the width of the window will wrap
                          " and displaying continues on the next line.
setlocal textwidth=79     " maximum width of text that is being inserted

" Q: set formatoptions doesn't work?
" A: https://stackoverflow.com/a/24170442
augroup ftplugin_rst
  au!
  autocmd BufWinEnter *.rst     setlocal formatoptions=tcqjmB
augroup END
