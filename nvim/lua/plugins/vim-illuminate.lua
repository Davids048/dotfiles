return {
    "RRethy/vim-illuminate",
    enabled = true,
    config = function ()
        require('illuminate').configure({
            under_cursor = true,
        })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Search" })
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Search" })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Search" })
        
    end
}
