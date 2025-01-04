local lfs = vim.loop -- Filesystem access (libuv)
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

-- Function to get Conda environments
local function get_conda_envs(base_dir)
    local envs = {}
    if not lfs.fs_stat(base_dir) then
        print("Directory does not exist: " .. base_dir)
        return envs
    end

    for name, type in vim.fs.dir(base_dir) do
        local env_path = base_dir .. "/" .. name
        local conda_meta_path = env_path .. "/conda-meta"
        if type == "directory" and lfs.fs_stat(conda_meta_path) then
            table.insert(envs, { name = name, path = env_path })
        end
    end
    return envs
end

-- Function to activate selected environment
local function activate_conda_env(env)
    if env then
        local python_path = env.path .. "/bin/python" -- Use `Scripts/python.exe` on Windows
        vim.g.python3_host_prog = python_path
        print("Activated Python interpreter: " .. python_path)

		-- Update Pyright after selecting Conda env
		require('lspconfig').pyright.setup({
			on_init = function(client)
				client.config.settings.python.pythonPath = python_path
				print("Pyright now using Python: " .. python_path)
			end,
		})
		vim.cmd("LspRestart") -- Restart the language server to apply changes
    end
end

-- Telescope picker to select and activate environment
local function pick_conda_env(base_dir)
    local conda_envs = get_conda_envs(base_dir)
    if #conda_envs == 0 then
        print("No Conda environments found.")
        return
    end

    pickers.new({}, {
        prompt_title = "Select Conda Environment",
        finder = finders.new_table({
            results = conda_envs,
            entry_maker = function(env)
                return {
                    value = env,
                    display = env.name,
                    ordinal = env.name,
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            local function select_env()
                local selected = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                activate_conda_env(selected.value)
            end
            map("i", "<CR>", select_env)
            map("n", "<CR>", select_env)
            return true
        end,
    }):find()
end

-- Command to list and select Conda env
vim.api.nvim_create_user_command("SelectCondaEnv", function()
    local conda_base = "/opt/miniconda3/envs" -- Replace with the base Conda environments directory
    pick_conda_env(conda_base)
end, {})

