let mapleader=" "

" Lexplore
nnoremap <Leader>e :Lexplore<CR>
nnoremap <Leader>E :Lexplore<CR>

" Netrw
let g:netrw_banner=0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
let g:netrw_altv = 1
augroup netrw_line_numbers
  autocmd!
  autocmd FileType netrw setlocal number
augroup END
