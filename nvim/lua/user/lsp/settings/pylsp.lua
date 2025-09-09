return {
	on_init = function(client)
        print("Python interpreter path: " .. vim.inspect(client.config.settings.pylsp.plugins.jedi_environment))
    end,
	settings = {
        pylsp = {
            plugins = {
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                pylint = { enabled = false },
				jedi_environment = vim.g.python3_host_prog,
            },
        },
    },
}
