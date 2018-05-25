set wrap                  " lines longer than the width of the window will wrap
                          " and displaying continues on the next line.
set textwidth=79          " maximum width of text that is being inserted

autocmd BufNewFile,BufRead,BufWinEnter *.wiki setlocal formatoptions=tcqjmB
