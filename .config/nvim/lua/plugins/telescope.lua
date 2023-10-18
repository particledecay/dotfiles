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
