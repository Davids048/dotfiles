-- Large File Warning Plugin for Neovim
-- Place this in ~/.config/nvim/lua/large-file-warning.lua

local M = {}

-- Configuration
M.config = {
  max_size = 2 * 1024 * 1024, -- 2MB in bytes
  warning_message = "This file is larger than 2MB (%s). Opening large files may cause performance issues. Continue?",
  default_tail_lines = 100,
  default_head_lines = 100,
  show_keybindings = true,
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

-- Validate file access and handle edge cases
local function validate_file_access(filepath)
  local expanded = vim.fn.expand(filepath)

  -- Check if file exists
  local stat = vim.loop.fs_stat(expanded)
  if not stat then
    vim.notify(string.format("File not found: %s", filepath), vim.log.levels.ERROR)
    return false
  end

  -- Handle symlinks
  if stat.type == "link" then
    local real_path = vim.loop.fs_realpath(expanded)
    if not real_path then
      vim.notify("Broken symlink", vim.log.levels.ERROR)
      return false
    end
    return validate_file_access(real_path)
  end

  -- Check if it's a file (not directory)
  if stat.type ~= "file" then
    vim.notify(string.format("Not a file: %s", filepath), vim.log.levels.ERROR)
    return false
  end

  -- Check read permission
  local fd = vim.loop.fs_open(expanded, "r", 438)
  if not fd then
    vim.notify(string.format("Permission denied: %s", filepath), vim.log.levels.ERROR)
    return false
  end
  vim.loop.fs_close(fd)

  return true
end

-- Check if file is binary
local function is_binary_file(filepath)
  local expanded = vim.fn.expand(filepath)
  local fd = vim.loop.fs_open(expanded, "r", 438)
  if not fd then
    return false
  end

  local data = vim.loop.fs_read(fd, 8192, 0)
  vim.loop.fs_close(fd)

  if not data then
    return false
  end

  -- Check for null bytes (common in binary files)
  return data:find("\0") ~= nil
end

-- Build terminal command based on mode
local function build_terminal_command(filepath, mode, lines)
  local escaped = vim.fn.shellescape(filepath)

  if mode == "tail" then
    return string.format("tail -n %d %s", lines, escaped)
  elseif mode == "tail-f" then
    return string.format("tail -f %s", escaped)
  elseif mode == "less" then
    return string.format("less %s", escaped)
  elseif mode == "head" then
    return string.format("head -n %d %s", lines, escaped)
  end
end

-- Show keybindings help
local function show_keybindings_help()
  local help_text = {
    "Large File Viewer Keybindings:",
    "",
    "  <leader>lt  - Switch to tail mode (last N lines)",
    "  <leader>lf  - Switch to tail -f mode (live monitoring)",
    "  <leader>ll  - Switch to less mode (pager)",
    "  <leader>lh  - Switch to head mode (first N lines)",
    "  <leader>l?  - Show this help",
    "",
    "  <Esc><Esc>  - Exit terminal mode and close",
  }

  vim.notify(table.concat(help_text, "\n"), vim.log.levels.INFO)
end

-- Switch terminal mode
local function switch_terminal_mode(bufnr, filepath, new_mode, lines)
  -- Stop current terminal job
  vim.api.nvim_buf_call(bufnr, function()
    vim.fn.jobstop(vim.b.terminal_job_id)
  end)

  -- Clear buffer content
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})

  -- Start new terminal with new mode
  local cmd = build_terminal_command(filepath, new_mode, lines)
  vim.api.nvim_buf_call(bufnr, function()
    vim.fn.termopen(cmd)
  end)

  -- Update buffer name and metadata
  local buf_name = string.format("[%s] %s", new_mode, vim.fn.fnamemodify(filepath, ":t"))
  vim.api.nvim_buf_set_name(bufnr, buf_name)
  vim.api.nvim_buf_set_var(bufnr, "large_file_mode", new_mode)
  if lines then
    vim.api.nvim_buf_set_var(bufnr, "large_file_lines", lines)
  end

  vim.notify(string.format("Switched to %s mode", new_mode), vim.log.levels.INFO)
end

-- Setup terminal buffer keymaps
local function setup_terminal_keymaps(bufnr, filepath, current_mode, lines)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "<leader>lt", function()
    switch_terminal_mode(bufnr, filepath, "tail", M.config.default_tail_lines)
  end, vim.tbl_extend("force", opts, { desc = "Switch to tail mode" }))

  vim.keymap.set("n", "<leader>lf", function()
    switch_terminal_mode(bufnr, filepath, "tail-f", nil)
  end, vim.tbl_extend("force", opts, { desc = "Switch to tail -f mode" }))

  vim.keymap.set("n", "<leader>ll", function()
    switch_terminal_mode(bufnr, filepath, "less", nil)
  end, vim.tbl_extend("force", opts, { desc = "Switch to less mode" }))

  vim.keymap.set("n", "<leader>lh", function()
    switch_terminal_mode(bufnr, filepath, "head", M.config.default_head_lines)
  end, vim.tbl_extend("force", opts, { desc = "Switch to head mode" }))

  vim.keymap.set(
    "n",
    "<leader>l?",
    show_keybindings_help,
    vim.tbl_extend("force", opts, { desc = "Show large file keybindings" })
  )

  -- Exit terminal
  vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>:q<CR>", opts)
end

-- Setup terminal buffer options and metadata
local function setup_terminal_buffer(bufnr, filepath, mode, lines)
  -- Set buffer options
  vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(bufnr, "buflisted", false)

  -- Set buffer name
  local buf_name = string.format("[%s] %s", mode, vim.fn.fnamemodify(filepath, ":t"))
  vim.api.nvim_buf_set_name(bufnr, buf_name)

  -- Store metadata for mode switching
  vim.api.nvim_buf_set_var(bufnr, "large_file_path", filepath)
  vim.api.nvim_buf_set_var(bufnr, "large_file_mode", mode)
  vim.api.nvim_buf_set_var(bufnr, "large_file_lines", lines or 0)

  -- Setup keymaps
  setup_terminal_keymaps(bufnr, filepath, mode, lines)

  -- Show help if enabled
  if M.config.show_keybindings then
    show_keybindings_help()
  end
end

-- Create terminal view for large file
local function create_terminal_view(filepath, mode, lines)
  -- Validate file
  if not validate_file_access(filepath) then
    return
  end

  -- Warn about binary files
  if is_binary_file(filepath) then
    vim.notify("Binary file detected. Viewing may produce unexpected results.", vim.log.levels.WARN)
  end

  -- Delete original buffer
  local original_buf = vim.api.nvim_get_current_buf()

  -- Create new tab
  vim.cmd("tabnew")
  local new_buf = vim.api.nvim_get_current_buf()

  -- Build and run command
  local cmd = build_terminal_command(filepath, mode, lines)
  vim.fn.termopen(cmd, {
    on_exit = function(_, exit_code)
      if exit_code ~= 0 then
        vim.notify(string.format("Terminal exited with code %d", exit_code), vim.log.levels.WARN)
      end
    end,
  })

  -- Setup buffer
  setup_terminal_buffer(new_buf, filepath, mode, lines)

  -- Delete original
  pcall(vim.api.nvim_buf_delete, original_buf, { force = true })
end

-- Handle view mode selection
local function handle_view_selection(selection, filepath)
  if selection:match("^Cancel") then
    vim.notify("File opening cancelled.", vim.log.levels.WARN)
    return
  end

  if selection:match("^Open as buffer") then
    -- Re-open file normally
    vim.cmd("edit " .. vim.fn.fnameescape(filepath))
    return
  elseif selection:match("^Tail %(last N") then
    -- Prompt for line count
    vim.ui.input({
      prompt = string.format("Number of lines (default: %d): ", M.config.default_tail_lines),
    }, function(input)
      local lines = tonumber(input) or M.config.default_tail_lines
      create_terminal_view(filepath, "tail", lines)
    end)
  elseif selection:match("^Tail %-f") then
    create_terminal_view(filepath, "tail-f", nil)
  elseif selection:match("^Less") then
    create_terminal_view(filepath, "less", nil)
  elseif selection:match("^Head") then
    vim.ui.input({
      prompt = string.format("Number of lines (default: %d): ", M.config.default_head_lines),
    }, function(input)
      local lines = tonumber(input) or M.config.default_head_lines
      create_terminal_view(filepath, "head", lines)
    end)
  end
end

-- Show view options using fzf-lua picker
local function show_view_options(filepath, formatted_size)
  local fzf_ok, fzf = pcall(require, "fzf-lua")
  if not fzf_ok then
    vim.notify("fzf-lua not available. Please install it to use large file viewer.", vim.log.levels.ERROR)
    return
  end

  local options = {
    "Open as buffer (normal edit)",
    "Tail (last N lines)",
    "Tail -f (live monitoring)",
    "Less (pager navigation)",
    "Head (first N lines)",
    "Cancel",
  }

  fzf.fzf_exec(options, {
    prompt = string.format("File is %s. Select viewing mode> ", formatted_size),
    actions = {
      ["default"] = function(selected)
        if selected and #selected > 0 then
          handle_view_selection(selected[1], filepath)
        end
      end,
    },
    winopts = {
      height = 0.4,
      width = 0.6,
    },
  })
end

-- Hook into file opening events
local function setup_autocmds()
  local group = vim.api.nvim_create_augroup("LargeFileWarning", { clear = true })

  vim.api.nvim_create_autocmd("BufReadPre", {
    group = group,
    callback = function(args)
      local filepath = args.file

      -- Skip special buffers
      if not filepath or filepath == "" or vim.startswith(filepath, "oil://") then
        return
      end

      -- Get file size
      local expanded_path = vim.fn.expand(filepath)
      local size = get_file_size(expanded_path)

      if not size then
        return
      end

      -- Check size limit
      if size > M.config.max_size then
        -- Stop buffer from loading
        vim.cmd("bdelete!")

        -- Show picker asynchronously
        vim.schedule(function()
          show_view_options(expanded_path, format_size(size))
        end)
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
