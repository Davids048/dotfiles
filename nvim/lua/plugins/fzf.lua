local config = {
  fzf_opts = {
    ["--cycle"] = true,      
    ["--header-lines"]=false
  },
  previewers = {
      default= 'cat'
  },
    winopts = {
      preview = {
        layout = 'vertical',
      },
    },
    grep = {
      regex = true
    }
}

return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  config = function()
    require("fzf-lua").setup(config)
  end,
}
