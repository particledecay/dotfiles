vim.g.codeium_no_map_tab = 1

-- set key to <Right>
vim.api.nvim_set_keymap('i', '<Right>', 'codeium#Accept()', { expr = true, silent = true })
