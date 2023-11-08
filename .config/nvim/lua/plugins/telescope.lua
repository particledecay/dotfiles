local dir = require('utils/dir')
local key = vim.api.nvim_set_keymap
local root_dir = dir.find_git_or_pwd(vim.fn.getcwd())

-- [nvim-telescope/telescope.nvim] use ctrl+p for fuzzy search
key('n', '<C-p>', '<cmd>Telescope find_files search_dirs={"' .. root_dir .. '"}<CR>', { noremap = true })
-- [nvim-telescope/telescope.nvim] use ctrl+g for fuzzy grep
key('n', '<C-g>', '<cmd>Telescope live_grep<CR>', { noremap = true })
-- [nvim-telescope/telescope.nvim] options
require('telescope').setup {
  defaults = {
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
    },
  }
}
