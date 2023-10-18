-- [tpope/vim-fugitive]
vim.api.nvim_set_keymap('n', 'gb', ':Git blame<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gB', ':GBrowse<CR>', { noremap = true, silent = true })
