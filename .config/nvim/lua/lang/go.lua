-- [sebdah/vim-delve]
vim.api.nvim_set_keymap('n', '<leader>db', ':DlvToggleBreakpoint<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dd', ':DlvDebug<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dt', ':DlvTest<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dc', ':DlvClearAll<CR>', { noremap = true })

-- Set keymap for Go coverage highlighting
vim.api.nvim_set_keymap('n', '<leader>gc', ':GoCoverageToggle<CR>', { noremap = true })
