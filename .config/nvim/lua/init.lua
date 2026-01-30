vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
    vim.keymap.set('n', 'L', vim.lsp.buf.implementation, { buffer = args.buf })
  end,
})

vim.diagnostic.config({
  virtual_text = true,
})

        -- note: must install the vscode-langservers-extracted package globally:
        --  npm i -g vscode-langservers-extracted
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.enable('eslint')
vim.lsp.config('eslint', {
  capabilities = capabilities,
})
vim.lsp.enable('html')
vim.lsp.config('html', {
  capabilities = capabilities,
})
vim.lsp.enable('css')
vim.lsp.config('css', {
  capabilities = capabilities,
})
vim.lsp.enable('json')
vim.lsp.config('json', {
  capabilities = capabilities,
})
