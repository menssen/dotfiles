local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
-- Packer can manage itself
use 'wbthomason/packer.nvim'

use {
  'neovim/nvim-lspconfig',
  config = function()
    require('lspconfig').eslint.setup({})
  end
}

use {
  'jose-elias-alvarez/typescript.nvim',
  config = function()
    require('typescript').setup({})
  end
}

use {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup()
  end
}

use {
  'folke/trouble.nvim',
  config = function()
    require('trouble').setup({
      icons = false,
      fold_open = 'v',
      fold_closed = '>',
      indent_lines = false,
      signs = {
        error = 'error',
        warning = 'warn',
        hint = 'hint',
        information = 'info',
      },
    })
  end
}

-- use 'nvim-lua/plenary.nvim'

use {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}

use {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('indent_blankline').setup({
      enabled = false
    })
  end
}

use {
  'nvim-treesitter/nvim-treesitter',
  run = function()
    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
  end,
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = "all",
      highlight = {
        enable = true
      }
    })
  end
}

use 'sainnhe/edge'
use 'tpope/vim-fugitive'
use 'tpope/vim-rhubarb'
use 'tpope/vim-surround'

--
-- Put this at the end after all plugins
if packer_bootstrap then
require('packer').sync()
end
end)
