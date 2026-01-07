return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local actions = require("fzf-lua.actions")

    require("fzf-lua").setup({
      fzf_opts = {
        ["--cycle"] = "",
        ["--header-lines"] = "0",
      },
      buffers = {
        actions = {
          ["ctrl-backspace"] = { fn = actions.buf_del, reload = true },
        },
      },
      previewers = {
        default = {
          cat = {},
        },
      },
      winopts = {
        preview = {
          layout = "vertical",
        },
      },
      grep = {
        regex = true,
      },
    })
  end,
}

