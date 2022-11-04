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
  use 'hrsh7th/cmp-nvim-lsp'                -- nvim-cmp source for LSP
  use 'hrsh7th/cmp-buffer'                  -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-path'                    -- nvim-cmp source for filesystem paths
  use 'hrsh7th/cmp-cmdline'                 -- nvim-cmp source for vim's cmdline
  use 'saadparwaiz1/cmp_luasnip'            -- nvim-cmp source for LuaSnip
  use 'hrsh7th/nvim-cmp'                    -- Autocompletion
  use 'L3MON4D3/LuaSnip'                    -- LSP Snippets engine
  use 'airblade/vim-rooter'                 -- Identify root directories and chdir to them
  use 'nvim-treesitter/nvim-treesitter'     -- Advanced semantic code analysis
  use 'jose-elias-alvarez/null-ls.nvim'     -- Make LSP configs easier
  use 'kyazdani42/nvim-web-devicons'        -- Icons
  use {
    'nvim-lualine/lualine.nvim',            -- Statusline
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
  use 'fatih/vim-go'                        -- Go support (better than lspconfig for now)
  use 'towolf/vim-helm'                     -- Helm chart support
  use 'folke/trouble.nvim'                  -- Better diagnostics

  -- Themes
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
    file_ignore_patterns = {'.git'},
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
  }
}

-- [nvim-treesitter/nvim-treesitter] enable modules
require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  highlight = { enable = true },
  indent = { enable = false },
}

-- [hrsh7th/nvim-cmp] enable sources and mappings
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.mapping.confirm({ select = true })
cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
})
-- [hrsh7th/nvim-cmp] use buffer source for '/'
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})
-- [hrsh7th/nvim-cmp] use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

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
vim.api.nvim_exec([[ colorscheme dracula ]], false)
