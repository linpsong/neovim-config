require("lspconfig").bufls.setup({ 
  cmd = { 'buf', 'beta', 'lsp', '--timeout=0', '--log-format=text' }, 
  filetypes = { 'proto' }, 
})
