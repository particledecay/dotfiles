-- Packer installation for Neovim packages
local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
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
  use 'wbthomason/packer.nvim'              -- Package manager
  use 'tpope/vim-fugitive'                  -- Git commands
  use 'tpope/vim-rhubarb'                   -- GitHub integration
  use 'tpope/vim-vinegar'                   -- netrw improvements
  use 'tpope/vim-commentary'                -- Code commenting
  use 'neovim/nvim-lspconfig'               -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-compe'                  -- Autocompletion
  use 'airblade/vim-rooter'                 -- Identify root directories and chdir to them
  use 'nvim-treesitter/nvim-treesitter'     -- Advanced semantic code analysis
  use 'kyazdani42/nvim-web-devicons'        -- Icons
  use {
    'hoob3rt/lualine.nvim',                 -- Statusline
    requires = {
      {
        'kyazdani42/nvim-web-devicons',
        opt = true,
      }
    }
  }
  use {
    'nvim-telescope/telescope.nvim',        -- Fuzzy finder
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    }
  }
  use {
    'lewis6991/gitsigns.nvim',              -- Git signs
    requires = {
      {'nvim-lua/plenary.nvim'},
    }
  }
  use {
    'euclio/vim-markdown-composer',         -- Markdown live preview
    run = 'cargo build --release'
  }
  use 'kristijanhusak/vim-carbon-now-sh'    -- Carbon Now code screenshots
  use 'chrisbra/csv.vim'                    -- CSV support
  use 'sebdah/vim-delve'                    -- Delve debugging
  use 'machakann/vim-sandwich'              -- Surround plugin
  use 'fatih/vim-go'                        -- Go support (better than LSP for now)
  use 'marko-cerovac/material.nvim'	        -- Material color scheme
  use 'dracula/vim'                         -- Dracula
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

-- Include line numbers in netrw (why isn't this the default?)
vim.g.netrw_bufsettings = 'noma nomod rnu nu nobl nowrap ro'

-- Don't save hidden buffers
vim.cmd('autocmd FileType netrw setl bufhidden=delete')

-- LSP configuration
require('lang/lspconfig')

-- Go-specific config
require('lang/go')

-- Python-specific config
require('lang/python')

-- [airblade/vim-rooter] patterns for finding root directory
vim.g.rooter_patterns = {
  '>Projects',
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
    prompt_position = 'top',
    file_ignore_patterns = {'.git'},
    sorting_strategy = 'ascending',
  }
}

-- [nvim-treesitter/nvim-treesitter] enable modules
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = { enable = true },
  indent = { enable = true },
}

-- [hrsh7th/nvim-compe] options
require('compe').setup {
  enabled = true,
  autocomplete = true,

  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = true,
  }
}
-- [hrsh7th/nvim-compe] mappings
function smart_tab()
    if vim.fn.pumvisible() ~= 0 then
        vim.api.nvim_eval([[feedkeys("\<c-n>", "n")]])
        return
    end

    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        vim.api.nvim_eval([[feedkeys("\<tab>", "n")]])
        return
    end

    vim.fn["compe#complete"]();
end
function smart_s_tab()
  if vim.fn.pumvisible() ~= 0 then
    vim.api.nvim_eval([[feedkeys("\<c-p>", "n")]])
    return
  end

  vim.api.nvim_eval([[feedkeys("\<s-tab>", "n")]])
end
vim.api.nvim_set_keymap('i', '<TAB>', '<cmd>lua smart_tab()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-TAB>', '<cmd>lua smart_s_tab()<CR>', { noremap = true, silent = true })

-- [lewis6991/gitsigns.nvim] options
require('gitsigns').setup {
  current_line_blame = true,
}

-- [hoob3rt/lualine.nvim]
require('lualine').setup {
  options = {
    theme = 'dracula'
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
vim.api.nvim_exec([[ colorscheme dracula ]], false)
