local Plugin = {
	event = "VeryLazy",
	"nvimtools/none-ls.nvim",
}

function Plugin.config()
	local null_ls = require("null-ls")
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.stylua,
			--null_ls.builtins.formatting.asmfmt,
			-- null_ls.builtins.formatting.prettier.with({
			-- 	filetypes = { "html", "json", "yaml", "markdown", "vue" },
			-- }),
			null_ls.builtins.formatting.black,
			null_ls.builtins.formatting.clang_format.with({
				filetypes = { "cpp", "cc", "h", "hpp", "hh", "c", "glsl" },
				extra_args = {
					"--style={BasedOnStyle: Microsoft, IndentWidth: 4}",
				},
			}),
			null_ls.builtins.formatting.cmake_format,
			--null_ls.builtins.diagnostics.eslint,
			--null_ls.builtins.completion.spell,
			-- null_ls.builtins.formatting.fourmolu,
			-- null_ls.builtins.diagnostics.golangci_lint,
			-- null_ls.builtins.formatting.gofmt,
			-- null_ls.builtins.diagnostics.buf,
			-- null_ls.builtins.formatting.buf,
			null_ls.builtins.formatting.nixfmt,
			null_ls.builtins.diagnostics.verilator,
			null_ls.builtins.formatting.verible_verilog_format,
		},

		--[[
    -- there has an issue:
    -- when vim.lsp.buf.formt() is called, the cursor move back.
    --]]
		-- you can reuse a shared lspconfig on_attach callback here
		on_attach = function(client, bufnr)
			if client:supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
						-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
						-- vim.lsp.buf.formatting_sync()
						vim.lsp.buf.format({
							async = false,
							timeout_ms = 5000,
							-- fix a issue that null-ls’s extra_args not applying consistently.
							-- sometimes default rules apply but not extra_args rules when we do not open
							-- the target filetype first (maybe we open a .txt and the a .cpp by telescope),
							filter = function(client)
								return client.name == "null-ls"
							end,
						})
					end,
				})
			end
		end,
	})
end

return Plugin
