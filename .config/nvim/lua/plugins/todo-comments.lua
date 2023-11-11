local dir = require('utils/dir')
local key = vim.api.nvim_set_keymap
local root_dir = dir.find_git_or_pwd(vim.fn.getcwd())

require('todo-comments').setup()

-- [folke/todo-comments.nvim] set keymaps
key('n', '<leader>tt', '<cmd>TodoTrouble cwd=' .. root_dir .. '<CR>', { noremap = true, silent = true })
key('n', '<leader>ts', '<cmd>TodoTelescope cwd=' .. root_dir .. '<CR>', { noremap = true, silent = true })
