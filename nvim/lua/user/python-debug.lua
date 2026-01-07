-- Command to parse Python stack trace lines and open file at the specified line
-- Usage: :DB File "/path/to/file.py", line 47, in function_name
local function parse_and_open_stack_line(stack_line)
  -- Pattern to match: File "path", line number
  local file_path, line_num = stack_line:match('File%s+"([^"]+)",%s+line%s+(%d+)')

  if file_path and line_num then
    -- Open the file
    vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
    -- Jump to the line
    vim.cmd('normal! ' .. line_num .. 'G')
    vim.cmd('normal! zz') -- Center the line in the window
    print('Opened ' .. file_path .. ' at line ' .. line_num)
  else
    print('Error: Could not parse stack trace line')
  end
end

-- Create the :DB command
vim.api.nvim_create_user_command('DB', function(opts)
  parse_and_open_stack_line(opts.args)
end, {
  nargs = '+',
  desc = 'Parse Python stack trace and open file at line'
}) 
