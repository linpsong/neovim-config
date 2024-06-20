require('lspconfig').clangd.setup({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
})
