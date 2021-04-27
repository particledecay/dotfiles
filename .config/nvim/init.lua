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
  use 'wbthomason/packer.nvim'		      -- Package manager
  use 'tpope/vim-fugitive'		          -- Git commands
  use 'tpope/vim-rhubarb'		            -- GitHub integration
  use 'tpope/vim-vinegar'		            -- netrw improvements
  use 'neovim/nvim-lspconfig'		        -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-compe'	    	      -- Autocompletion
  use 'airblade/vim-rooter'             -- Identify root directories and chdir to them
  use 'nvim-treesitter/nvim-treesitter' -- Advanced semantic code analysis
  use 'kyazdani42/nvim-web-devicons'    -- Icons
  use {
    'famiu/feline.nvim',                -- Statusline
    config = require('feline').setup()
  }
  use {
    'nvim-telescope/telescope.nvim',    -- Fuzzy finder
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    }
  }
  use {
    'lewis6991/gitsigns.nvim',          -- Git signs
    requires = {
      {'nvim-lua/plenary.nvim'},
    }
  }
  use 'marko-cerovac/material.nvim'	    -- Material color scheme
end)

-- Global options
vim.o.mouse = 'v'                       -- Allow middle-click paste with mouse
vim.o.wildmode = 'longest,list'         -- Get bash-like tab completions
vim.o.encoding = 'utf-8'                -- UTF-8 encoding
vim.o.fileformat = 'unix'               -- unix-style line formatting
vim.o.inccommand = 'nosplit'            -- Incremental live completion
vim.o.hidden = true                     -- Do not save when switching buffers
vim.o.termguicolors = true              -- Terminal colors
vim.o.completeopt = 'menuone,noselect'  -- Allow for autocompletion

-- Buffer options
vim.bo.tabstop = 2              -- Number of columns occupied by tab character
vim.bo.softtabstop = 2          -- See multiple spaces as tabstops so <BS> does the right thing
vim.bo.expandtab = true         -- Convert tabs to white space
vim.bo.shiftwidth = 2           -- Width for autoindents
vim.bo.autoindent = true        -- Indent a new line the same amount as the line just typed

-- Window options
vim.wo.number = true		-- Enable numbers
vim.wo.relativenumber = true    -- Use relative numbering

-- Remap comma as leader key
vim.api.nvim_set_keymap('', ',', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Easier split window navigations
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', { noremap = true })

-- LSP settings
local nvim_lsp = require('lspconfig')
local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F12>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-F12>', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<S-F12>', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-S-F12>', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F8>', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

-- LSP: Go
require('lspconfig').gopls.setup {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod' },
  on_attach = on_attach,
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

-- LSP: Python
require('lspconfig').pyls.setup {
  cmd = { 'pyls' },
  filetypes = { 'python' },
  on_attach = on_attach,
}

-- LSP: Terraform
require('lspconfig').terraformls.setup {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'hcl' },
  on_attach = on_attach,
}

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

-- [marko-cerovac/material.vim]
vim.g.material_style = 'palenight'
vim.g.material_italic_comments = true
vim.g.material_italic_keywords = true
vim.g.material_italic_functions = true
vim.g.material_italic_variables = false
vim.g.material_contrast = true
vim.g.material_borders = false
require('material').set()
