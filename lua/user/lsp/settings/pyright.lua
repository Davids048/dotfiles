return {
	settings = {

    python = {
      analysis = {
        typeCheckingMode = "off"
      },
	  pythonPath = vim.g.python3_host_prog,
    },
	analysis = {
		extraPaths = {vim.fn.getcwd()},
	}
	},
}
