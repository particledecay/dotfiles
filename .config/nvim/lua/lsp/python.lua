local lspconfig = require('lspconfig')
local lspformat = require('lsp-format')

-- Python virtualenv for Neovim
vim.g.python3_host_prog = "$HOME/.pyenv/versions/3.8.18/bin/python"

-- prefer virtualenv (check env var) if available otherwise default to python3_host_prog
if vim.env.VIRTUAL_ENV then
  vim.g.python3_host_prog = vim.env.VIRTUAL_ENV .. "/bin/python"
end

lspconfig.pylsp.setup({ on_attach = lspformat.on_attach })
