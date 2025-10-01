local config_func = function()
    local status_ok, lualine = pcall(require, "lualine")
    if not status_ok then
        return
    end

    local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end

    local diagnostics = {
        "diagnostics",
        sources = { "nvim_lsp" },
        sections = { "error", "warn" },
        symbols = { error = "[E]", warn = "[W]" },
        colored = false,
        update_in_insert = false,
        always_visible = true,
    }

    local diff = {
        "diff",
        colored = false,
        symbols = { added = "[+]", modified = "[~]", removed = "[-]" }, -- changes diff symbols
      cond = hide_in_width
    }

    local mode = {
        "mode",
        fmt = function(str)
            return "-- " .. str .. " --"
        end,
    }

    local filetype = {
        "filetype",
        icons_enabled = false,
        icon = nil,
    }

    local branch = {
        "branch",
        icons_enabled = false,
        icon = "",
    }

    local location = {
        "location",
        padding = 0,
    }

    lualine.setup({
        options = {
            icons_enabled = false,
            theme = "dracula",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = { "dashboard", "NvimTree", "Outline", "netrw"},
            always_divide_middle = true,
        },
        sections = {
            lualine_a = { branch, diff },
            lualine_b = { mode },
            lualine_c = {
                {
                    "filename",
                    file_status = true,
                    path = 2,
                }
            },
            lualine_x = { "encoding", "fileformat", "filetype" },
            -- lualine_x = { diff, spaces, "encoding", filetype },
            lualine_y = { location },
            lualine_z = { diagnostics },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {},
    })

    end



return {
    'nvim-lualine/lualine.nvim',
    config = config_func,
}
