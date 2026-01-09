local M = {}

function M.preview_definition()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
    if err then
      vim.notify("Error requesting definition: " .. tostring(err), vim.log.levels.ERROR)
      return
    end

    if not result or vim.tbl_isempty(result) then
      vim.notify("No definition found", vim.log.levels.WARN)
      return
    end

    local location = vim.tbl_islist(result) and result[1] or result

    -- Extract location info
    local uri = location.uri or location.targetUri
    local range = location.range or location.targetRange
    local filename = vim.uri_to_fname(uri)
    local start_line = range.start.line

    -- Read the entire file
    local bufnr = vim.fn.bufadd(filename)
    vim.fn.bufload(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    -- Show large context around definition (100 lines before and after)
    local context_lines = 100
    local preview_start = math.max(0, start_line - context_lines)
    local preview_end = math.min(#lines - 1, start_line + context_lines)

    -- Extract preview content
    local preview_lines = {}
    for i = preview_start + 1, preview_end + 1 do
      table.insert(preview_lines, lines[i])
    end

    -- Create scratch buffer for preview
    local preview_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(preview_buf, 0, -1, false, preview_lines)

    -- Set filetype for syntax highlighting
    local ft = vim.filetype.match({ filename = filename })
    if ft then
      vim.api.nvim_buf_set_option(preview_buf, 'filetype', ft)
    end

    -- Make buffer readonly
    vim.api.nvim_buf_set_option(preview_buf, 'modifiable', false)
    vim.api.nvim_buf_set_option(preview_buf, 'bufhidden', 'wipe')

    -- Calculate window dimensions
    local width = math.min(120, vim.o.columns - 10)
    local height = math.min(40, #preview_lines, vim.o.lines - 10)

    -- Prepare file path for footer
    local display_path = vim.fn.fnamemodify(filename, ':~:.')
    if #display_path > width - 4 then
      display_path = "..." .. string.sub(display_path, -(width - 7))
    end

    -- Create floating window
    local win = vim.api.nvim_open_win(preview_buf, true, {
      relative = 'editor',
      width = width,
      height = height,
      col = math.floor((vim.o.columns - width) / 2),
      row = math.floor((vim.o.lines - height) / 2),
      style = 'minimal',
      border = 'rounded',
      footer = {{" " .. display_path .. " ", "Special"}},
      footer_pos = 'center',
    })

    -- Set window options for better viewing
    vim.api.nvim_win_set_option(win, 'wrap', false)
    vim.api.nvim_win_set_option(win, 'cursorline', true)
    vim.api.nvim_win_set_option(win, 'number', true)
    vim.api.nvim_win_set_option(win, 'relativenumber', false)
    vim.api.nvim_win_set_option(win, 'winhighlight', 'FloatBorder:Special')

    -- Position cursor at the definition line
    local def_line_in_preview = start_line - preview_start + 1
    vim.api.nvim_win_set_cursor(win, {def_line_in_preview, 0})

    -- Center the cursor line
    vim.cmd('normal! zz')

    -- Add keymaps to close the window
    local close_cmd = string.format(':lua vim.api.nvim_win_close(%d, true)<CR>', win)
    vim.api.nvim_buf_set_keymap(preview_buf, 'n', 'q', close_cmd, {silent = true, nowait = true})
    vim.api.nvim_buf_set_keymap(preview_buf, 'n', '<Esc>', close_cmd, {silent = true, nowait = true})

    -- Add keymap to open file in buffer
    local open_cmd = string.format(
      ':lua vim.api.nvim_win_close(%d, true) vim.cmd("edit " .. vim.fn.fnameescape("%s")) vim.api.nvim_win_set_cursor(0, {%d, 0})<CR>',
      win, filename, start_line + 1
    )
    vim.api.nvim_buf_set_keymap(preview_buf, 'n', '<CR>', open_cmd, {silent = true, nowait = true})
    vim.api.nvim_buf_set_keymap(preview_buf, 'n', 'o', open_cmd, {silent = true, nowait = true})
  end)
end

return M
