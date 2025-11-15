-- setup must be called before loading
vim.cmd.colorscheme "retrobox"

vim.api.nvim_set_hl(0, 'WinSeparator', {
  fg = '#ffaa00',  -- Change to your preferred color
  bg = 'NONE'      -- Transparent background
})

vim.api.nvim_set_hl(0, 'MsgSeparator', {
  fg = '#ffaa00',  -- separator line color
  bg = 'NONE',     -- transparent background
})

vim.api.nvim_set_hl(0, 'LineNr', {
  fg = '#555555',
  bg = '#222222'
})


vim.api.nvim_set_hl(0, 'TabLineSel', {
  fg = '#cccccc',
  bg = '#444444'
})

vim.api.nvim_set_hl(0, 'TabLineFill', {
  bg = '#666666'
})

vim.api.nvim_set_hl(0, 'MsgArea', {
  bg = '#222222'
})

vim.api.nvim_set_hl(0, 'TelescopeSelection', {
  bg = '#333333'
})


-- Functions (make them stand out more)
vim.api.nvim_set_hl(0, 'Function', { fg = '#87afd7', bold = false })

-- Variables (green color)
vim.api.nvim_set_hl(0, 'Identifier', { fg = '#98d982' })

-- Strings (warmer tint, easier to spot)
vim.api.nvim_set_hl(0, 'String', { fg = '#d7af5f' })

-- Search matches
vim.api.nvim_set_hl(0, 'Search', { fg = '#ffffff', bg = '#444444', bold = true })

-- Current search match
vim.api.nvim_set_hl(0, 'IncSearch', { fg = '#000000', bg = '#ff9e54', bold = true })

-- NvimTree folder names
vim.api.nvim_set_hl(0, 'NvimTreeFolderName', { fg = '#87afd7' })
vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#3a3a3a" })

vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3a3a3a" })
vim.api.nvim_set_hl(0, "IblScope", { fg = "#505050" })
