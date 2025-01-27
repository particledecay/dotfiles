-- Both visual and normal mode for each, so you can open with a visual selection or without.
vim.api.nvim_set_keymap('v', '<leader>a', ':GPTModelsCode<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>a', ':GPTModelsCode<CR>', { noremap = true })

vim.api.nvim_set_keymap('v', '<leader>c', ':GPTModelsChat<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>c', ':GPTModelsChat<CR>', { noremap = true })
