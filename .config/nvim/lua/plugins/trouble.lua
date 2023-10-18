require('trouble').setup {}

-- [folke/trouble.nvim]
vim.api.nvim_set_keymap('n', '<C-t>', ':TroubleToggle<CR>', { noremap = true, silent = true })
