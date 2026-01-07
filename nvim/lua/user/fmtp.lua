vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    local function split_top_level_args(s)
      local args, cur = {}, {}
      local p, b, c = 0, 0, 0             -- paren, bracket, brace depths (inside the arglist)
      local in_str, q, esc = false, nil, false
      for i = 1, #s do
        local ch = s:sub(i,i)
        if in_str then
          table.insert(cur, ch)
          if esc then
            esc = false
          elseif ch == "\\" then
            esc = true
          elseif ch == q then
            in_str, q = false, nil
          end
        else
          if ch == '"' or ch == "'" then
            in_str, q = true, ch; table.insert(cur, ch)
          elseif ch == '(' then p = p + 1; table.insert(cur, ch)
          elseif ch == ')' then p = p - 1; table.insert(cur, ch)
          elseif ch == '[' then b = b + 1; table.insert(cur, ch)
          elseif ch == ']' then b = b - 1; table.insert(cur, ch)
          elseif ch == '{' then c = c + 1; table.insert(cur, ch)
          elseif ch == '}' then c = c - 1; table.insert(cur, ch)
          elseif ch == ',' and p == 0 and b == 0 and c == 0 then
            local seg = table.concat(cur):gsub("^%s+", ""):gsub("%s+$", "")
            if seg ~= "" then table.insert(args, seg) end
            cur = {}
          else
            table.insert(cur, ch)
          end
        end
      end
      local last = table.concat(cur):gsub("^%s+", ""):gsub("%s+$", "")
      if last ~= "" then table.insert(args, last) end
      return args
    end

    vim.api.nvim_buf_create_user_command(0, 'FMTP', function()
      local bufnr = 0
      local row = vim.api.nvim_win_get_cursor(0)[1] - 1
      local line = vim.api.nvim_buf_get_lines(bufnr, row, row+1, false)[1]
      if not line or line == "" then return end

      -- Replace the whole "Find the matching arglist parens..." section with this:

      local function find_pair(line)
        local ps, bs, brs = {}, {}, {}
        local in_str, q, esc = false, nil, false
        local last = { l=nil, r=nil, opener=nil, closer=nil }
        for i = 1, #line do
          local ch = line:sub(i,i)
          if in_str then
            if esc then esc=false
            elseif ch == "\\" then esc=true
            elseif ch == q then in_str, q = false, nil end
          else
            if ch == '"' or ch == "'" then in_str, q = true, ch
            elseif ch == '(' then table.insert(ps, i)
            elseif ch == ')' then
              local lft = table.remove(ps)
              if lft then last = { l=lft, r=i, opener='(', closer=')' } end
            elseif ch == '{' then table.insert(bs, i)
            elseif ch == '}' then
              local lft = table.remove(bs)
              if lft then last = { l=lft, r=i, opener='{', closer='}' } end
            elseif ch == '[' then table.insert(brs, i)
            elseif ch == ']' then
              local lft = table.remove(brs)
              if lft then last = { l=lft, r=i, opener='[', closer=']' } end
            end
          end
        end
        return last.l, last.r, last.opener, last.closer
      end
      
      local l, r, opener, closer = find_pair(line)
      if not l or not r then
        vim.notify("PySplitArgs: no (), {}, or [] pair found on this line.", vim.log.levels.WARN)
        return
      end
      
      local inside = line:sub(l+1, r-1)
      local args = split_top_level_args(inside)
      if #args == 0 then
        vim.notify("PySplitArgs: nothing to split at top level.", vim.log.levels.WARN)
        return
      end

      -- -- Find the matching arglist parens for the *last* ')', ignoring those in strings.
      -- local l, r, stack = nil, nil, {}
      -- local in_str, q, esc = false, nil, false
      -- for i = 1, #line do
      --   local ch = line:sub(i,i)
      --   if in_str then
      --     if esc then esc = false
      --     elseif ch == "\\" then esc = true
      --     elseif ch == q then in_str, q = false, nil end
      --   else
      --     if ch == '"' or ch == "'" then in_str, q = true, ch
      --     elseif ch == '(' then table.insert(stack, i)
      --     elseif ch == ')' then
      --       l = table.remove(stack)  -- matching '(' for this ')'
      --       r = i                    -- keep updating; at the end, this is the outermost pair
      --     end
      --   end
      -- end
      -- if not l or not r or r <= l then
      --   vim.notify("PySplitArgs: couldn't find a function-call paren pair on this line.", vim.log.levels.WARN)
      --   return
      -- end
      --
      -- local inside = line:sub(l+1, r-1)
      -- local args = split_top_level_args(inside)
      -- if #args == 0 then
      --   vim.notify("PySplitArgs: no top-level arguments found to split.", vim.log.levels.WARN)
      --   return
      -- end

      local head   = line:sub(1, l)        -- up to and including '('
      local tail   = line:sub(r+1)         -- after ')', keep any trailing text/comment
      -- local aindent = string.rep(" ", l)   -- align args under the char after '('
      -- local cindent = string.rep(" ", l-1) -- align ')' under '(' (PEP 8 style)
      local base_indent = (line:match("^(%s*)") or "")
      local sw = vim.bo.shiftwidth
      if sw == 0 then sw = vim.bo.tabstop end
      if sw == 0 then sw = 4 end
      local aindent = base_indent .. string.rep(" ", sw)  -- +1 indent level
      local cindent = base_indent                         -- ')' aligns with start of statement

      local new = { head }
      for _, a in ipairs(args) do
        table.insert(new, aindent .. a .. ",")
      end
      -- BEFORE
      -- table.insert(new, cindent .. ")" .. tail)
  
      -- AFTER
      table.insert(new, cindent .. closer .. tail)


      vim.api.nvim_buf_set_lines(bufnr, row, row+1, false, new)
    end, { desc = "Split function-call args on the current line into one-per-line" })
  end,
})
