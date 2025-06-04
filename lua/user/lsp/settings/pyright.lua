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
