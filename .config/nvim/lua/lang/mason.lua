local mason = require('mason')
local masonlsp = require('mason-lspconfig')
local lspconfig = require('lspconfig')
local lspformat = require('lsp-format')
local servers = {
  'ansiblels',                       -- Ansible
  'bashls',                          -- Bash
  'dockerls',                        -- Docker
  'docker_compose_language_service', -- Docker Compose
  'golangci_lint_ls',                -- Go (linting)
  'gopls',                           -- Go
  'html',                            -- HTML
  'helm_ls',                         -- Helm
  'biome',                           -- JavsScript, JSON, TypeScript
  'lua_ls',                          -- Lua
  'marksman',                        -- Markdown
  'pylsp',                           -- Python
  'ruby_ls',                         -- Ruby
  'terraformls',                     -- Terraform
  'yamlls',                          -- YAML
}

mason.setup()
masonlsp.setup({ ensure_installed = servers })
lspformat.setup({ sync = true })

-- set up the language servers
for _, server in ipairs(servers) do
  lspconfig[server].setup({ on_attach = lspformat.on_attach })
end

-- keybindings
-- go to definition
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
-- hover
vim.api.nvim_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
-- go to references
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
-- source code refactoring
vim.api.nvim_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
