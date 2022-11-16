local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
-- Packer can manage itself
use 'wbthomason/packer.nvim'

use 'neovim/nvim-lspconfig'
use 'jose-elias-alvarez/typescript.nvim'
use 'b3nj5m1n/kommentary'
use 'nvim-lua/plenary.nvim'
use 'jose-elias-alvarez/null-ls.nvim'
use 'MunifTanjim/eslint.nvim'
--[[ use {
  'tanvirtin/vgit.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  }
} ]]

use 'tpope/vim-fugitive'
--
-- Put this at the end after all plugins
if packer_bootstrap then
require('packer').sync()
end
end)
