local colorscheme = "tokyonight"
-- local colorscheme = "default"

vim.g.tokyonight_dark_sidebar = false

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
