local config_func = function()
    require("lsp_signature").setup({})
end

return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  config = config_func,
}
