local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local M = {}
function M.recent_dirs()
  local dirs = {}
  for _, file in ipairs(vim.v.oldfiles) do
    local dir = vim.fn.fnamemodify(file, ":p:h")
    if vim.fn.isdirectory(dir) == 1 and not vim.tbl_contains(dirs, dir) then
      table.insert(dirs, dir)
    end
  end

  require('telescope.pickers').new({}, {
    prompt_title = "Recent Directories",
    finder = require('telescope.finders').new_table {
      results = dirs,
    },
    sorter = require('telescope.config').values.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
	  -- Action to open Telescope's file browser in the selected directory
      local function open_in_file_browser()
        local selection = action_state.get_selected_entry()
        local dir = selection[1]
        actions.close(prompt_bufnr)
        require('telescope').extensions.file_browser.file_browser({ path = dir })
      end

      map('n', 'o', actions.select_default + actions.center)
	  map('n', 'O', open_in_file_browser)

      return true
    end,
  }):find()
end

-- Register the function as a Neovim command
vim.api.nvim_create_user_command('RecentDirs', function()
  M.recent_dirs()
end, {})

vim.cmd([[
  cnoreabbrev <expr> red getcmdtype() == ":" && getcmdline() == "red" ? "RecentDirs" : "red"
]])

return M

