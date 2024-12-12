local dap, dapui = require('dap'), require('dapui')

-- Open and close DAP UI automatically
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- Python-specific configuration
require('dap-python').setup(vim.g.python3_host_prog)

-- Go-specific configuration
require('dap-go').setup()

-- Keymaps
vim.api.nvim_set_keymap('n', '<leader>dc', '<cmd>lua require("dap").continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>db', '<cmd>lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dn', '<cmd>lua require("dap").step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>di', '<cmd>lua require("dap").step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua require("dap").step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>du', '<cmd>lua require("dapui").toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dr', '<cmd>lua require("dap").repl.toggle()<CR>', { noremap = true, silent = true })
