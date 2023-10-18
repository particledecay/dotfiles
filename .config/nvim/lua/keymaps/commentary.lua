-- [tpope/vim-commentary] toggle comment lines
vim.api.nvim_set_keymap('n', '<C-_>', ':Commentary<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-_>', ':Commentary<CR>', { noremap = true, silent = true })
