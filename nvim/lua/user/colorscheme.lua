-- require("catppuccin").setup({
--     flavour = "mocha", -- latte, frappe, macchiato, mocha
--     background = { -- :h background
--         light = "latte",
--         dark = "mocha",
--     },
--     transparent_background = false, -- disables setting the background color.
--     show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
--     term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
--     dim_inactive = {
--         enabled = true, -- dims the background color of inactive window
--         shade = "dark",
--         percentage = 0.30, -- percentage of the shade to apply to the inactive window
--     },
--     no_italic = false, -- Force no italic
--     no_bold = false, -- Force no bold
--     no_underline = false, -- Force no underline
--     styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
--         comments = { "italic" }, -- Change the style of comments
--         conditionals = { "italic" },
--         loops = {},
--         functions = {},
--         keywords = {},
--         strings = {},
--         variables = {},
--         numbers = {},
--         booleans = {},
--         properties = {},
--         types = {},
--         operators = {},
--         -- miscs = {}, -- Uncomment to turn off hard-coded styles
--     },
--     color_overrides = {
-- 		mocha = {
-- 			base = "#000000",
-- 			mantle = "#1a1a1a",
-- 			crust = "#000000",
-- 		},
-- 	},
--     custom_highlights = function(colors)
--         return {
--             WinSeparator = { fg = colors.pink },
--         }
--     end,
--     default_integrations = true,
--     integrations = {
--         cmp = true,
--         gitsigns = true,
--         nvimtree = true,
--         treesitter = true,
--         notify = false,
--         mini = {
--             enabled = true,
--             indentscope_color = "",
--         },
--         -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
--     },
-- })

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
-- vim.api.nvim_set_hl(0, 'String', { fg = '#d7af5f' })

-- Search matches
vim.api.nvim_set_hl(0, 'Search', { fg = '#ffffff', bg = '#444444', bold = true })

-- Current search match
vim.api.nvim_set_hl(0, 'IncSearch', { fg = '#000000', bg = '#ff9e54', bold = true })

