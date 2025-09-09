local function compile_and_run_with_log(debug_mode)
	vim.cmd("write")

    -- Get filename details
    local filename_no_ext = vim.fn.expand("%:r")
	-- Assert the filename 
	assert(not string.find(filename_no_ext, "_tc_")
		and not string.find(filename_no_ext, "log"),
		"Invalid filename: contains _tc_ or log")

    local filename = vim.fn.expand("%")
    local debug_flags = "-fsanitize=address -DDEBUG"
    local common_flags = "-std=c++17 -Wall -Wextra -Wshadow -DONPC -DLOCAL -O2"

    -- Compile and run commands
    local compile_command = string.format("g++ %s %s -o %s %s > log 2>&1", debug_mode and debug_flags or "", common_flags, filename_no_ext, filename)
    -- local run_command = string.format("./%s < _tc_ > log 2>&1", filename_no_ext)
	local timeout_seconds = 5  -- Set your timeout duration in seconds
	local run_command = string.format("gtimeout %s ./%s < _tc_ > log 2>&1", timeout_seconds, filename_no_ext)

	local delete_command = string.format("rm -f %s", filename_no_ext)  -- Remove executable after run


    -- vim.fn.system(compile_command) -- Compile
	vim.fn.system(compile_command)

	if vim.v.shell_error == 0 then
		vim.fn.system(run_command)     -- Run and generate log
		if vim.v.shell_error ~= 0 then
			vim.fn.system("echo 'timeout after 5 seconds' >> log")
		end
		vim.fn.system(delete_command)  -- Delete executable
	else
		print("Compilation failed! Check log for details.")
	end


    -- Save current window (code window)
    local code_win = vim.api.nvim_get_current_win()

    -- Find existing `_tc_` and `log` windows (if any)
    local tc_file = "_tc_"
    local log_file = "log"
    local tc_win = nil
    local log_win = nil

    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
        if buf_name:match(tc_file .. "$") then
            tc_win = win
        elseif buf_name:match(log_file .. "$") then
            log_win = win
        end
    end

    -- Open or reuse `_tc_` window
    if not tc_win then
        vim.cmd("vsplit " .. tc_file)
        tc_win = vim.api.nvim_get_current_win()
    else
        vim.api.nvim_set_current_win(tc_win)
        vim.cmd("edit " .. tc_file)
    end

    -- Open or reuse `log` window below `_tc_`
    if not log_win then
        vim.cmd("split log")
        log_win = vim.api.nvim_get_current_win()
    else
        vim.api.nvim_set_current_win(log_win)
        vim.cmd("edit log")
    end

    -- Ensure `log` is below `_tc_` by resizing
    vim.api.nvim_win_set_height(log_win, math.floor(vim.o.lines * 0.4)) -- Resize log window to ~40% of the height

    -- Restore focus to code window
    vim.api.nvim_set_current_win(code_win)

    print("Compilation and execution completed! 🎉 Check log for details.")
end

-- Key mappings
vim.keymap.set("n", "<F10>", function() compile_and_run_with_log(true) end, { noremap = true, silent = true })
vim.keymap.set("n", "<F9>", function() compile_and_run_with_log(false) end, { noremap = true, silent = true })

