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
  use 'hrsh7th/cmp-copilot'
  use 'hrsh7th/nvim-cmp'

  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands
  use 'tpope/vim-rhubarb' -- GitHub integration
  use 'tpope/vim-vinegar' -- netrw improvements
  use 'tpope/vim-commentary' -- Code commenting
  use 'airblade/vim-rooter' -- Identify root directories and chdir to them
  use 'kyazdani42/nvim-web-devicons' -- Icons
  use 'neovim/nvim-lspconfig' -- LSP config support
  use 'williamboman/mason.nvim' -- LSP installer
  use 'williamboman/mason-lspconfig.nvim' -- LSP configurer

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'

  use {
    'nvim-treesitter/nvim-treesitter', -- Advanced semantic code analysis
    run = ':TSUpdate'
  }

  use {
    'jose-elias-alvarez/null-ls.nvim', -- Make LSP configs easier
    requires = {
      { 'nvim-lua/plenary.nvim' },
    }
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
    }
  }
  use {
    'euclio/vim-markdown-composer', -- Markdown live preview
    run = 'cargo build --release'
  }
  use 'kristijanhusak/vim-carbon-now-sh' -- Carbon Now code screenshots
  use 'chrisbra/csv.vim' -- CSV support
  use 'sebdah/vim-delve' -- Delve debugging
  use 'machakann/vim-sandwich' -- Surround plugin
  use 'fatih/vim-go' -- Go support (better than lspconfig for now)
  use 'towolf/vim-helm' -- Helm chart support
  use 'b0o/schemastore.nvim' -- JSON Schemas

  -- Better diagnostics
  use {
    'folke/trouble.nvim',
    requires = {
      {
        'kyazdani42/nvim-web-devicons',
        opt = true,
      }
    },
    config = function()
      require('trouble').setup {}
    end
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

  -- ActivityWatcher
  use 'ActivityWatch/aw-watcher-vim'

  -- Themes
  use 'Mofiqul/dracula.nvim'
end)

-- Global settings
require('settings/global')

-- Buffer settings
require('settings/buffer')

-- Window settings
require('settings/window')

-- Remap comma as leader key
vim.api.nvim_set_keymap('', ',', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Easier split window navigations
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', { noremap = true })

-- Copy to clipboard
vim.api.nvim_set_keymap('n', '<leader>Y', '"+yg_', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true })

-- Paste from clipboard
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>P', '"+P', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>P', '"+P', { noremap = true })

-- Open terminal
vim.api.nvim_set_keymap('n', '<leader>t', ':terminal<CR>', { noremap = true })

-- Include line numbers in netrw (why isn't this the default?)
vim.g.netrw_bufsettings = 'noma nomod rnu nu nobl nowrap ro'

-- Don't save hidden buffers
vim.cmd('autocmd FileType netrw setl bufhidden=delete')

-- LSP configuration
require('lang/lspconfig')

-- Completion sources
require('lang/comp')

-- Language-specific configs
require('lang/docker')
require('lang/go')
require('lang/python')
require('lang/terraform')

-- GitHub Copilot
require('lang/copilot')

-- [airblade/vim-rooter] patterns for finding root directory
vim.g.rooter_patterns = {
  '>projects',
  '.git',
  '.github',
  'setup.py',
  'setup.cfg',
  'Makefile',
  'Taskfile',
  'go.mod',
  'package.json',
  'requirements.txt',
}
-- [airblade/vim-rooter] do not echo project directory
vim.g.rooter_silent_chdir = true

-- [nvim-telescope/telescope.nvim] use ctrl+p for fuzzy search
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<CR>', { noremap = true })
-- [nvim-telescope/telescope.nvim] use ctrl+g for fuzzy grep
vim.api.nvim_set_keymap('n', '<C-g>', '<cmd>Telescope live_grep<CR>', { noremap = true })
-- [nvim-telescope/telescope.nvim] options
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { '.git' },
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
  }
}

-- [nvim-treesitter/nvim-treesitter] enable modules
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'awk',
    'bash',
    'dockerfile',
    'fish',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'go',
    'gomod',
    'gosum',
    'hcl',
    'html',
    'htmldjango',
    'ini',
    'javascript',
    'jq',
    'json',
    'json5',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'python',
    'regex',
    'ruby',
    'rust',
    'scss',
    'sql',
    'terraform',
    'toml',
    'vim',
    'yaml',
  },
  highlight = { enable = true },
  indent = { enable = false },
}

-- [L3MON4D3/LuaSnip]
require('luasnip.loaders.from_vscode').lazy_load()

-- [rafamadriz/friendly-snippets]
local snip = require('luasnip')
snip.filetype_extend('django', {'django'})
snip.filetype_extend('docker', {'docker'})
snip.filetype_extend('go', {'go'})
snip.filetype_extend('javascript', {'javascript'})
snip.filetype_extend('kubernetes', {'kubernetes'})
snip.filetype_extend('make', {'make'})
snip.filetype_extend('python', {'python'})
snip.filetype_extend('shell', {'shell'})
snip.filetype_extend('sql', {'sql'})

-- [williamboman/mason]
require('mason').setup()

-- [tpope/vim-commentary]
vim.api.nvim_set_keymap('n', '<C-_>', ':Commentary<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-_>', ':Commentary<CR>', { noremap = true, silent = true })

-- [lewis6991/gitsigns.nvim] options
require('gitsigns').setup {
  current_line_blame = true,
}

-- [hoob3rt/lualine.nvim]
require('lualine').setup {
  options = {
    theme = 'dracula',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  }
}

-- [tpope/vim-fugitive]
vim.api.nvim_set_keymap('n', 'gb', ':Git blame<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gB', ':GBrowse<CR>', { noremap = true, silent = true })

-- [kristijanhusak/vim-carbon-now-sh]
vim.g.carbon_now_sh_options = {
  bg = 'rgba(123%252C182%252C221%252C0)',
  t = 'dracula-pro',
  wt = 'none',
  l = 'auto',
  ds = 'true',
  dsyoff = '14px',
  dsblur = '15px',
  wc = 'true',
  wa = 'true',
  pv = '44px',
  ph = '44px',
  ln = 'true',
  fm = 'MonoLisa',
  fs = '14.5px',
  lh = '142%252525',
  si = 'false',
  es = '2x',
  wm = 'false',
}
-- [kristijanhusak/vim-carbon-now-sh] use F12 for taking screenshots
vim.api.nvim_set_keymap('v', '<F12>', ':CarbonNowSh<CR>', { noremap = true })

-- [dracula/vim]
require('dracula').setup({
  italic_comment = true,
})
vim.api.nvim_exec([[ colorscheme dracula ]], false)
