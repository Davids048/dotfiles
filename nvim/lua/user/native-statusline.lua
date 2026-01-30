vim.o.laststatus = 2
vim.o.statusline = table.concat({
  '[~%{winwidth(0) > 80 && system("git branch --show-current 2>/dev/null | tr -d \'\\n\'") != "" ? system("git branch --show-current 2>/dev/null | tr -d \'\\n\'") : ""}]',
  '[%f]',
  '%{&modified?" [+]":""}',      -- show [+] if modified
  '%{&readonly?" [RO]":""}',     -- show [RO] if readonly
  '%=',
  '[%{mode()}]',
  ' %l:%c',
  ' [%p%%]',
  ' [%{&filetype}]',
})

vim.opt.winbar = "%f %m"

local function darken(color, amount)
  if not color then
    return nil
  end

  local r = math.floor(color / 0x10000) % 0x100
  local g = math.floor(color / 0x100) % 0x100
  local b = color % 0x100

  local function dim(channel)
    return math.max(0, math.floor(channel * (1 - amount)))
  end

  return string.format("#%02x%02x%02x", dim(r), dim(g), dim(b))
end

local function apply_statusline_fg()
  local statusline = vim.api.nvim_get_hl(0, { name = "StatusLine" })

  vim.api.nvim_set_hl(0, "StatusLine", {
    fg = "#ffffff",
    bg = statusline.bg,
  })
  vim.api.nvim_set_hl(0, "StatusLineNC", {
    fg = "#ffffff",
    bg = darken(statusline.bg, 0.8),
  })
end

apply_statusline_fg()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_statusline_fg,
})
