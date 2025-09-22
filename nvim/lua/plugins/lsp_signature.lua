local config_func = function()
    require("lsp_signature").setup({
      floating_window = false,
      floating_window_off_x = 4,
      hint_inline = function() return 'eol' end,
      hint_prefix = {
        above = "↙ ",  -- when the hint is on the line above the current line
        current = "← ",  -- when the hint is on the same line
        below = "↖ "  -- when the hint is on the line below the current line
      },
      toggle_key = '<C-k>'
    })
end

return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  config = config_func,
}
