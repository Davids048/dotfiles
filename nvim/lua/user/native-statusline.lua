vim.o.laststatus = 2
vim.o.statusline = table.concat({
  '[%f]',
  '%{&modified?" [+]":""}',      -- show [+] if modified
  '%{&readonly?" [RO]":""}',     -- show [RO] if readonly
  '%=',
  '[%{mode()}]',
  ' %l:%c',
  ' [%{&filetype}]',
})

