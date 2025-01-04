local lfs = vim.loop -- Filesystem access (libuv)
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local config_file_path = vim.fn.stdpath("config") .. "/config/conda_env_config"

-- Ensure the config directory exists
local config_dir = vim.fn.stdpath("config") .. "/config"
if lfs.fs_stat(config_dir) == nil then
    lfs.fs_mkdir(config_dir, 493) -- 0o755 permission
end

-- Function to read the base directory from the config file
local function read_base_dir()
    local file = io.open(config_file_path, "r")
    if file then
        local base_dir = file:read("*l")
        file:close()
        return base_dir
    end
    return nil
end

-- Function to write the base directory to the config file
local function write_base_dir(base_dir)
    local file = io.open(config_file_path, "w")
    if file then
        file:write(base_dir .. "\n")
        file:close()
        print("Saved Conda base directory: " .. base_dir)
    else
        print("Error: Unable to save base directory.")
    end
end

-- Function to get Conda environments
local function get_conda_envs(base_dir)
    local envs = {}
    if not base_dir or not lfs.fs_stat(base_dir) then
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

-- Function to pick and activate a Conda environment
local function pick_conda_env(base_dirs)
    local base_dir = base_dirs[1]
    if not base_dir then
        return
    end

    local conda_envs = get_conda_envs(base_dir)
    if #conda_envs == 0 then
        print("No Conda environments found in: " .. base_dir)
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

-- Function to prompt user for a base directory
local function prompt_for_base_dir()
    vim.ui.input({ prompt = "Enter the Conda base directory: " }, function(input)
        if input and lfs.fs_stat(input) then
            write_base_dir(input)
            pick_conda_env({ input }) -- Now `pick_conda_env` is recognized here
        else
            print("Invalid directory. Please try again.")
        end
    end)
end

-- Command to list and select Conda environment
vim.api.nvim_create_user_command("SelectCondaEnv", function()
    local base_dir = read_base_dir()
    if base_dir then
        pick_conda_env({ base_dir })
    else
        print("No base directory found. Please specify a directory.")
        prompt_for_base_dir()
    end
end, {})

