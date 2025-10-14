
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = false
    vim.opt_local.cindent = false
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.g.python_indent = {
  disable_parentheses_indenting = false,
  closed_paren_align_last_line = false,
  searchpair_timeout = 150,
  continue = "shiftwidth()",
  open_paren = "shiftwidth()",
  nested_paren = "shiftwidth()",
}


return {
	settings = {

    python = {
      analysis = {
        typeCheckingMode = "on"
      },
	  pythonPath = vim.g.python3_host_prog,
    },
	analysis = {
		extraPaths = {vim.fn.getcwd()},
	}
	},
}
