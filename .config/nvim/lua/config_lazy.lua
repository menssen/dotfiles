-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { 'Apeiros-46B/qalc.nvim' },
    { 'github/copilot.vim' },
    { 'numToStr/Comment.nvim' },
    { 'neovim/nvim-lspconfig' },
    {
      'hrsh7th/nvim-cmp',
      dependencies = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer' },
      config = function()
        local cmp = require('cmp')
        cmp.setup({
          completion = {
            autocomplete = false,
          },
          sources = {
            { name = 'nvim_lsp' },
            { name = 'buffer' },
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.scroll_docs(5),
            ["<C-y>"] = cmp.mapping.scroll_docs(-5),
            ["<CR>"] = cmp.mapping.confirm(),
          }),
        })
        vim.cmd [[
          set completeopt=menu,menuone,noselect
          highlight! default link CmpItemKind CmpItemMenuDefault
        ]]
      end,
    },
    {
      'nvim-telescope/telescope.nvim', branch = 'master',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
      'lukas-reineke/indent-blankline.nvim',
      main = "ibl",
      opts = { enabled = false },
    },
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter.configs').setup({
          ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'bash', 'typescript', 'javascript', 'json', 'diff', 'dot', 'go', 'java', 'jq', 'kotlin', 'markdown', 'markdown_inline', 'sql', 'yaml' },
          highlight = {
            enable = true,
          },
        })
      end
    },
    {
      'pmizio/typescript-tools.nvim',
      dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
      config = function()
        require('typescript-tools').setup {
          settings = {
            jsx_close_tag = {
              enable = true,
              filetypes = { 'javascriptreact', 'typescriptreact' },
            },
          }
        }
      end
    },
    {
      'nvimtools/none-ls.nvim',
      dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
      config = function()

        local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
        local event = "BufWritePre" -- or "BufWritePost"
        local async = event == "BufWritePost"

        require('null-ls').setup({
          on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
              vim.keymap.set("n", "<Leader>r", function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
              end, { buffer = bufnr, desc = "[lsp] format" })

              -- format on save
              vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
              vim.api.nvim_create_autocmd(event, {
                buffer = bufnr,
                group = group,
                callback = function()
                  vim.lsp.buf.format({ bufnr = bufnr, async = async })
                end,
                desc = "[lsp] format on save",
              })
            end

            if client.supports_method("textDocument/rangeFormatting") then
              vim.keymap.set("x", "<Leader>r", function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
              end, { buffer = bufnr, desc = "[lsp] format" })
            end
          end,
        })
      end
    },
    {
      'MunifTanjim/prettier.nvim',
      dependencies = { 'nvimtools/none-ls.nvim' },
      config = function()
        require('prettier').setup({
          bin='prettierd',
          cli_options = {
            semi = false,
            single_quote = true,
            experimental_ternaries = true,
          },
        })
      end,
    },
    { 'sainnhe/edge' },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },
    { 'tpope/vim-surround' },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "edge" } },
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    notify = false,
  },
})
