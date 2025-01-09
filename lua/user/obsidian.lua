local status_ok, obsidian = pcall(require, "obsidian")
if not status_ok then
	return
end


obsidian.setup({
  workspaces = {
    {
      name = "personal",
      path = "~/Documents/Obsidian Vault/",
    },
  },

  -- see below for full list of options 👇
    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
  completion = {
    -- Set to false to disable completion.
    nvim_cmp = true,
    -- Trigger completion at 2 chars.
    min_chars = 2,
  },


})

