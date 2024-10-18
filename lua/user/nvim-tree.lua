-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

-- local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
-- if not config_status_ok then
--     return
-- end

-- local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
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
