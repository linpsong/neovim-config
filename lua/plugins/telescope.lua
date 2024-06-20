local plugin = { "nvim-telescope/telescope.nvim" }

-- telescope
plugin.cmd = "Telescope"

plugin.keys = {
	{ "<leader>ff", ":Telescope find_files<cr>", desc = "find files" },
	{ "<leader>lg", ":Telescope live_grep<cr>", desc = "grep files" },
	{ "<leader>rs", ":Telescope resume<cr>", desc = "resume" },
	{ "<leader>of", ":Telescope oldfiles<cr>", desc = "old files" },
}

plugin.tag = "0.1.3"

plugin.dependencies = { "nvim-lua/plenary.nvim" }

return plugin
