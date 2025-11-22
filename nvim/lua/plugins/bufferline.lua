local config = {}

return {
  "akinsho/bufferline.nvim",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  config = function()
    require("bufferline").setup(config)
  end,
}
