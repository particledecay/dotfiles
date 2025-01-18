require('trouble').setup {}

-- [folke/trouble.nvim]
vim.api.nvim_set_keymap('n', '<C-t>', ':Trouble diagnostics toggle focus=true filter.buf=0<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':Trouble symbols toggle pinned=true win.relative=win win.position=right<CR>',
  { noremap = true, silent = true })
