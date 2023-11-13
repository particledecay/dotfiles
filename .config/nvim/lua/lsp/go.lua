local dir = require('utils/dir')
local noremap = { noremap = true }
local key = vim.api.nvim_set_keymap
local root_dir = dir.find_go_ancestor(vim.fn.getcwd())

-- [sebdah/vim-delve]
key('n', '<leader>dd', string.format(':DlvDebug --build-flags="-gcflags=\'all=-N -l\'" %s<CR>', root_dir), noremap)
key('n', '<leader>dt', string.format(':DlvTest<CR>', root_dir), noremap)
key('n', '<leader>db', ':DlvToggleBreakpoint<CR>', noremap)
key('n', '<leader>dc', ':DlvClearAll<CR>', noremap)

-- [fatih/vim-go]
key('n', '<leader>gc', ':GoCoverageToggle<CR>', noremap)
vim.g.go_gopls_enabled = true
vim.g.go_gopls_options = { '-remote=auto' }
