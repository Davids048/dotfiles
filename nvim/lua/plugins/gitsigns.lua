local config = {
    sign_priority = 20,  -- Higher than diagnostics (default 10), so gitsigns always show
}

return {
    "lewis6991/gitsigns.nvim",
    name = "gitsigns",
    config = function()
        require("gitsigns").setup(config)
    end,
}
