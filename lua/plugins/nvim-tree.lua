local Plugin = { "nvim-tree/nvim-tree.lua" }

Plugin.dependencies = {
	{
		"nvim-tree/nvim-web-devicons",
	},
}

Plugin.version = "*"

Plugin.lazy = false

function Plugin.init()
	-- Example using a list of specs with the default options
	vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

	-- nvim-tree setup
	-- disable netrw at the very start of your init.lua
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	-- optionally enable 24-bit colour
	vim.opt.termguicolors = true
end

-- nvim-tree key map
local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

function Plugin.config()
	require("nvim-tree").setup({
		sort = {
			sorter = "case_sensitive",
		},

		git = {
			enable = true,
		},

		view = {
			-- width = 36,
			width = 25,
			side = "left",
			number = false,
			relativenumber = false,
			signcolumn = "yes",
		},

		renderer = {
			group_empty = true,
		},

		filters = {
			dotfiles = true,
		},

		on_attach = my_on_attach,
	})
end

return Plugin
