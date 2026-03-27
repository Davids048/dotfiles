set statusline=%F               " File path
set statusline+=\ %m            " Modified flag
set statusline+=\ %r            " Readonly flag
set statusline+=\ %h            " Help buffer flag
set statusline+=\ %w            " Preview window flag
set statusline+=%=              " Switch to right side
set statusline+=\ %y            " File type
set statusline+=\ [%{&ff}]      " File format
set statusline+=\ %p%%          " Percentage through file
set statusline+=\ %l:%c         " Line:Column
set statusline+=\ [%L]          " Total lines
