local Plugin = {

	-- colorschemes
	{
		"ellisonleao/gruvbox.nvim",
		requires = "rktjmp/lush.nvim",
		--config = function()
		--  vim.cmd.set("background=dark")
		--  vim.cmd.colorscheme("gruvbox")
		--end
	},

	{
		"sainnhe/gruvbox-material",
		requires = "rktjmp/lush.nvim",
		config = function()
			vim.cmd.set("background=dark")
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},

	{
		"sainnhe/everforest",
		requires = "rktjmp/lush.nvim",
		-- config = function()
		--   vim.cmd.colorscheme("everforest")
		-- end
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
}

return Plugin
