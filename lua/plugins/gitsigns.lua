local config = {
    
}

return {
    "lewis6991/gitsigns.nvim",
    name = "gitsigns",
    config = function()
        require("gitsigns").setup(config)
    end,
}
