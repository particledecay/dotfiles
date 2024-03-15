-- Remap comma as leader key
vim.api.nvim_set_keymap('', ',', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- add "# pragma: allowlist secret" to end of line
vim.api.nvim_set_keymap('n', '<leader>S', 'A # pragma: allowlist secret<ESC>:noh<CR>',
  { noremap = true, silent = true })
-- remove "# pragma: allowlist secret" from end of line
vim.api.nvim_set_keymap('n', '<leader>s', ':%s/ # pragma: allowlist secret$//<CR>:noh<CR>',
  { noremap = true, silent = true })
-- add '# pragma: allowlist secret' to end of all selected lines
vim.api.nvim_set_keymap('v', '<leader>S', ':s/$/ # pragma: allowlist secret/<CR>:noh<CR>',
  { noremap = true, silent = true })
-- remove '# pragma: allowlist secret' from end of all selected lines
vim.api.nvim_set_keymap('v', '<leader>s', ':s/ # pragma: allowlist secret$//<CR>:noh<CR>',
  { noremap = true, silent = true })
