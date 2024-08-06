-- Packer installation for Neovim packages
local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- Copilot
local copilot_path = vim.fn.stdpath('data') .. '/site/pack/github/start/copilot.vim'

if vim.fn.empty(vim.fn.glob(copilot_path)) > 0 then
  execute('!git clone https://github.com/github/copilot.vim.git ' .. copilot_path)
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

-- Packer plugins
local use = require('packer').use
require('packer').startup(function()
  -- Completion
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'

  use 'wbthomason/packer.nvim'            -- Package manager
  use 'tpope/vim-fugitive'                -- Git commands
  use 'tpope/vim-rhubarb'                 -- GitHub integration
  use 'tpope/vim-vinegar'                 -- netrw improvements
  use 'tpope/vim-commentary'              -- Code commenting
  use 'airblade/vim-rooter'               -- Identify root directories and chdir to them
  use 'nvim-tree/nvim-web-devicons'       -- Icons
  use 'neovim/nvim-lspconfig'             -- LSP config support
  use 'williamboman/mason.nvim'           -- LSP installer
  use 'williamboman/mason-lspconfig.nvim' -- LSP configurer
  use 'lukas-reineke/lsp-format.nvim'     -- Autoformatting

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'

  use {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('lsp/copilot')
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter', -- Advanced semantic code analysis
    run = ':TSUpdate'
  }

  use {
    'nvim-lualine/lualine.nvim', -- Statusline
    requires = {
      {
        'kyazdani42/nvim-web-devicons',
        opt = true,
      }
    }
  }
  use {
    'nvim-telescope/telescope.nvim', -- Fuzzy finder
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    }
  }
  use {
    'lewis6991/gitsigns.nvim', -- Git signs
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'seanbreckenridge/gitsigns-yadm.nvim' },
    }
  }
  use {
    'euclio/vim-markdown-composer', -- Markdown live preview
    run = 'cargo build --release'
  }
  use {
    'nvim-tree/nvim-tree.lua', -- nvim-tree plugin
    requires = {
      { 'nvim-tree/nvim-web-devicons' }
    }
  }
  use 'kristijanhusak/vim-carbon-now-sh' -- Carbon Now code screenshots
  use 'chrisbra/csv.vim'                 -- CSV support
  use 'sebdah/vim-delve'                 -- Delve debugging
  use 'machakann/vim-sandwich'           -- Surround plugin
  use 'fatih/vim-go'                     -- Go support (better than lspconfig for now)
  use 'towolf/vim-helm'                  -- Helm chart support
  use 'b0o/schemastore.nvim'             -- JSON Schemas

  -- Better diagnostics
  use {
    'folke/trouble.nvim',
    requires = {
      {
        'kyazdani42/nvim-web-devicons',
        opt = true,
      }
    }
  }

  -- TODO comments
  use {
    'folke/todo-comments.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope.nvim',
        opt = true,
      },
      {
        'folke/trouble.nvim',
        opt = true,
      },
    },
  }

  -- Git diffs
  use {
    'sindrets/diffview.nvim',
    requires = {
      {
        'nvim-lua/plenary.nvim',
      }
    }
  }

  -- GitHub reviews
  use {
    'pwntester/octo.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    }
  }

  -- Themes
  use {
    'catppuccin/nvim',
    as = 'catppuccin',
  }
  -- dracula
  use 'Mofiqul/dracula.nvim'
end)

-- Global settings
require('settings/global')

-- Buffer settings
require('settings/buffer')

-- Window settings
require('settings/window')

-- Keymaps
require('keymaps/global')
require('keymaps/window')
require('keymaps/buffer')
require('keymaps/clipboard')
require('keymaps/commentary')
require('keymaps/fugitive')
require('keymaps/github')

-- LSP configuration
require('lsp/mason')

-- Language-specific configs
require('lsp/go')
require('lsp/python')

-- Plugin configs
require('plugins/comp')
require('plugins/treesitter')
require('plugins/lualine')
require('plugins/rooter')
require('plugins/telescope')
require('plugins/snippets')
require('plugins/fugitive')
require('plugins/gitsigns')
require('plugins/carbon-now')
require('plugins/markdown')
require('plugins/trouble')
require('plugins/todo-comments')
require('plugins/github')
require('plugins/catppuccin')
-- require('plugins/dracula')
require('plugins/nvim-tree')


-- Colorscheme
-- vim.cmd.colorscheme 'dracula'
vim.cmd.colorscheme 'catppuccin-macchiato'
