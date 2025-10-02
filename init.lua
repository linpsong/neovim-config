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
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
	capabilities = capabilities,
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
