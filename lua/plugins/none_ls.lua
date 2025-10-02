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
					"-style={BasedOnStyle: Microsoft, IndentWidth: 4}",
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
						-- get current cursor position
						local row, col = unpack(vim.api.nvim_win_get_cursor(0))

						-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
						-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
						-- vim.lsp.buf.formatting_sync()
						vim.lsp.buf.format({ async = false, timeout_ms = 5000 })

						-- get the line count after formatting
						local lines = vim.api.nvim_buf_line_count(0)
						if row > lines then
							row, col = lines, 0
						else
							-- get current line after formatting
							local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
							-- find first word
							local s, e = line:find("%w+")
							col = s and (s - 1) or 0
						end
						-- set cursor positon
						vim.api.nvim_win_set_cursor(0, { row, col })
					end,
				})
			end
		end,
	})
end

return Plugin
