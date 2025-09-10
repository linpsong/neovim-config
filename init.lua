-- basic
require("user.basic")

-- filetype
require("user.filetype")

-- shell
require("user.shell")

-- keybindings
require("user.keybindings")

-- plugins
require("user.plugins")

-- Defined in init.lua
vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
			completion = {
				editsNearCursor = true,
			},
		},
		offsetEncoding = "utf-16",
	},
	root_markers = { ".git" },
})

vim.lsp.enable({
	-- lua
	"luals",

	-- nix
	"nixd",

	-- c/c++
	"clangd",

	-- glsl
	"glsl_analyzer",

	-- python
	"pyright",
})
