local Plugin = { "neovim/nvim-lspconfig" }
local user = {}

Plugin.dependencies = {
	{ "folke/neodev.nvim", opts = {} },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "williamboman/mason-lspconfig.nvim" },
}

Plugin.cmd = { "LspInfo", "LspInstall", "LspUnInstall" }

Plugin.event = { "BufReadPre", "BufNewFile" }

function Plugin.init()
	local sign = function(opts)
		-- See :help sign_define()
		vim.fn.sign_define(opts.name, {
			texthl = opts.name,
			text = opts.text,
			numhl = "",
		})
	end

	sign({ name = "DiagnosticSignError", text = "✘" })
	sign({ name = "DiagnosticSignWarn", text = "▲" })
	sign({ name = "DiagnosticSignHint", text = "⚑" })
	sign({ name = "DiagnosticSignInfo", text = "»" })

	-- See :help vim.diagnostic.config()
	vim.diagnostic.config({
		virtual_text = true,
		severity_sort = true,
		float = {
			border = "rounded",
			source = "always",
		},
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

function Plugin.config()
	local lspconfig = require("lspconfig")
	local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

	local group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		desc = "LSP actions",
		callback = user.on_attach,
	})

	-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
	require("neodev").setup({
		-- add any options here, or leave empty to use the default settings
	})

	-- See :help mason-lspconfig-settings
	require("mason-lspconfig").setup({
    ensure_installed = {
      'bufls',
      -- others
    },
		handlers = {
			-- See :help mason-lspconfig-dynamic-server-setup
			function(server)
				-- See :help lspconfig-setup
				lspconfig[server].setup({
					capabilities = lsp_capabilities,
				})
			end,
			["lua_ls"] = function()
				-- if you install the language server for lua it will
				-- load the config from lua/plugins/lsp/lua_ls.lua
				require("plugins.lsp.lua_ls")
			end,
			--[[
			["pyright"] = function()
				require("plugins.lsp.pyright")
			end,
			--]]
			--[[ --]]
			["pylsp"] = function()
				require("plugins.lsp.pylsp")
			end,
			--[[ --]]
			["clangd"] = function()
				require("plugins.lsp.clangd")
			end,
			["glsl_analyzer"] = function()
				require("plugins.lsp.glsl_analyzer")
			end,
			["hls"] = function()
				require("plugins.lsp.haskell_language_server")
			end,
			["powershell_es"] = function()
				require("plugins.lsp.powershell_es")
			end,
			["gopls"] = function()
				require("plugins.lsp.gopls")
			end,
      ["bufls"] = function()
        require("plugins.lsp.buf_ls")
      end,
		},
	})

	local function setup_lsp_diags()
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = false,
			signs = true,
			update_in_insert = false,
			underline = true,
		})
	end
	setup_lsp_diags()
end

function user.on_attach(event)
	local bufmap = function(mode, lhs, rhs)
		local opts = { buffer = event.buf }
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	-- You can search each function in the help page.
	-- For example :help vim.lsp.buf.hover()

	bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
	bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
	bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
	bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
	bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
	bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
	bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
	bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
	bufmap({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>")
	bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
	bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
	bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
	bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
end

return Plugin
