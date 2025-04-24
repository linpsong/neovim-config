require("lspconfig").clangd.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
	}, 
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' }, 
  -- filetypes = { "cpp", "cc", "h", "hpp", "hh", "c", "cuda" },
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
})
