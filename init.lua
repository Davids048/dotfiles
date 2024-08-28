require("user.user-commands")

require("tokyonight").setup({
  -- use the night style
  style = "night",
  -- disable italic for functions
  styles = {
    functions = {}
  },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_colors = function(colors)
    colors.hint = colors.orange
    colors.error = "#ff0000"
	colors.bg = "#333940"
	colors.bg_sidebar = "#080808"
	colors.bg_visual = "#55689e"
  end
})
require("user.colorscheme")

require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.cmp")
require("user.lsp")
require("user.telescope")
require("user.gitsigns")
require("user.nvim-tree")
require("nvim-tree").setup({})
require("user.bufferline")
require("user.toggleterm")
require("user.lualine")
require("Comment").setup()
require("user.context")

