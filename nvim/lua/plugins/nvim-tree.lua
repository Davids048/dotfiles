local config_func = function()
    require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    -- open_on_setup = true,
    -- ignore_ft_on_setup = {
    --     "startify",
    --     "dashboard",
    --     "alpha",
    -- },
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = "H",
            info = "I",
            warning = "W",
            error = "E",
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
    },
    sync_root_with_cwd = true,

    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
    view = {
        width = {
            min = 40,
            max = 100,
        },
        side = "left",
        centralize_selection = false,

        number = true,
        relativenumber = false,
    },
    actions = {
        open_file = {
            quit_on_open = false,
            window_picker = { enable = true },
        }
    },
    renderer = {
        highlight_git = "all",
        root_folder_modifier = ":t",
        icons = {
            show = {
                file = false,
                folder = true,
                folder_arrow = false,
                git = true,
            },
            glyphs = {
                default = "",
                symlink = "~",
                modified = "[+]",
                git = {
                    unstaged = "[M]",
                    staged = "S",
                    unmerged = "[!]",
                    renamed = "[R]",
                    deleted = "[-]",
                    untracked = "[U]",
                    ignored = "[*]",
                },
                folder = {
                    -- arrow_closed = ">",
                    -- arror_open = "v",
                    default = ">",
                    open = "V",
                    empty = "[e]",
                    empty_open = "[o*]",
                    symlink = "~",
                },
            }
        }
    }
})
end


return {
  "nvim-tree/nvim-tree.lua",
  enabled=true,
  version = "*",
  lazy = false,
  config = config_func,
}
