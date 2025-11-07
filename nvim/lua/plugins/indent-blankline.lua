local config_func = function()
    require("ibl").setup()
    end

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = config_func

}
