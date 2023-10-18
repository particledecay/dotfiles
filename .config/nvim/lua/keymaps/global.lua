-- Remap comma as leader key
vim.api.nvim_set_keymap('', ',', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Open terminal
vim.api.nvim_set_keymap('n', '<leader>t', ':terminal<CR>', { noremap = true })
