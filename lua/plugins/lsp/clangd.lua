local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local cmp_nvim_lsp = require "cmp_nvim_lsp"
lspconfig.clangd.setup({
  capabilities = lsp_capabilities,
  on_attach = on_attach,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
})
