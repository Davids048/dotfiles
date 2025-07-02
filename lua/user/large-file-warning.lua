-- Large File Warning Plugin for Neovim
-- Place this in ~/.config/nvim/lua/large-file-warning.lua

local M = {}

-- Configuration
M.config = {
  max_size = 2 * 1024 * 1024, -- 2MB in bytes
  warning_message = "This file is larger than 2MB (%s). Opening large files may cause performance issues. Continue?",
}

-- Setup function to allow user configuration
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

-- Format file size for display
local function format_size(bytes)
  if bytes < 1024 then
    return string.format("%d B", bytes)
  elseif bytes < 1024 * 1024 then
    return string.format("%.1f KB", bytes / 1024)
  else
    return string.format("%.1f MB", bytes / (1024 * 1024))
  end
end

-- Check if file exists and get its size
local function get_file_size(filepath)
  local stat = vim.loop.fs_stat(filepath)
  if stat and stat.type == "file" then
    return stat.size
  end
  return nil
end

-- Main function to check file size before opening
local function check_file_size(filepath)
  -- Skip if no filepath or if it's a special buffer
  if not filepath or filepath == "" or vim.startswith(filepath, "oil://") then
    return true
  end
  
  -- Expand the filepath to handle relative paths and ~
  local expanded_path = vim.fn.expand(filepath)
  
  -- Get file size
  local size = get_file_size(expanded_path)
  
  -- If we can't get the size, allow opening (file might not exist yet)
  if not size then
    return true
  end
  
  -- Check if file exceeds size limit
  if size > M.config.max_size then
    local formatted_size = format_size(size)
    local message = string.format(M.config.warning_message, formatted_size)

    -- Show confirmation dialog
        -- Show input prompt requiring Enter
    local response = vim.fn.input(message .. "(y/N): ")
    vim.cmd("redraw!")
    vim.api.nvim_echo({}, false, {})


    -- Return true if user typed 'y' or 'yes' (case insensitive), false otherwise
    local lower_response = string.lower(vim.trim(response))
    return lower_response == "y" or lower_response == "yes"
  end

  -- File is small enough, allow opening
  return true
end

-- Hook into file opening events
local function setup_autocmds()
  local group = vim.api.nvim_create_augroup("LargeFileWarning", { clear = true })

  -- Handle opening files via command line arguments or :edit command
  vim.api.nvim_create_autocmd("BufReadPre", {
    group = group,
    callback = function(args)
      local filepath = args.file

      if not check_file_size(filepath) then
        -- User chose not to open the file
        vim.cmd("bdelete!")
        vim.notify("File opening cancelled.", vim.log.levels.WARN)
        return
      end
    end,
  })

  -- Handle opening files via :open, gf, etc.
  vim.api.nvim_create_autocmd("FileReadPre", {
    group = group,
    callback = function(args)
      local filepath = args.file

      if not check_file_size(filepath) then
        -- Prevent the file from being read
        vim.cmd("throw 'File opening cancelled by user'")
        vim.notify("File opening cancelled.", vim.log.levels.WARN)
        return
      end
    end,
  })
end

-- Initialize the plugin
function M.init()
  setup_autocmds()
end

-- Command to manually check current buffer's file size
vim.api.nvim_create_user_command("CheckFileSize", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath == "" then
    vim.notify("No file associated with current buffer", vim.log.levels.INFO)
    return
  end

  local size = get_file_size(filepath)
  if size then
    local formatted_size = format_size(size)
    vim.notify(string.format("File size: %s", formatted_size), vim.log.levels.INFO)
  else
    vim.notify("Could not determine file size", vim.log.levels.WARN)
  end
end, {})

M.setup() -- Use default settings
M.init()  -- Initialize the plugin
