local config_func = function()
    require("ibl").setup({
        scope = { enabled = false },
    })
    end


vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3a3a3a" })
vim.api.nvim_set_hl(0, "IblScope", { fg = "#505050" })

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = config_func
}
