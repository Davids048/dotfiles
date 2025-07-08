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
    -- update_focused_file = {
    --     enable = true,
    --     update_cwd = true,
    --     ignore_list = {},
    -- },
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

        -- mappings = {
        --     custom_only = false,
        --     list = {
        --     { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        --     { key = "h", cb = tree_cb "close_node" },
        --     { key = "v", cb = tree_cb "vsplit" },
        --     },
        -- },
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
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    untracked = "[U]",
                    ignored = "◌",
                },
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
            }
        }
    }
})
end


return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = config_func,
}
