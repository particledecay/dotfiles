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

-- define custom settings map for any servers that need it
local overrides = {
  ansiblels = {
    ansible = {
      path = '/usr/bin/ansible',
    },
    ansibleLint = {
      enabled = true,
      path = '/usr/bin/ansible-lint',
    },
    python = {
      interpreterPath = vim.g.python3_host_prog,
    },
  },
  gopls = {
    analyses = {
      unusedparams = true,
    },
    staticcheck = true,
    vulncheck = true,
  },
  helm_ls = {
    lint = {
      with = 'helm',
    },
  },
  lua_ls = {
    diagnostics = {
      globals = { 'vim' },
    },
  },
  marksman = {
    lint = {
      with = 'markdownlint',
    },
  },
  terraformls = {
    filetypes = { 'terraform', 'terraform-vars', 'tf', 'hcl' },
    format = {
      args = { 'fmt', '-' },
      command = 'terraform',
      stdin = true,
    },
  },
  yamlls = {
    schemas = {
      ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose.yml',
    },
  },
}

mason.setup()
masonlsp.setup({ ensure_installed = servers })
lspformat.setup({ sync = true })

-- set up the language servers
for _, server in ipairs(servers) do
  -- initialize each language server with override settings if found
  if overrides[server] then
    lspconfig[server].setup(vim.tbl_deep_extend('force', overrides[server], { on_attach = lspformat.on_attach }))
  else
    lspconfig[server].setup({ on_attach = lspformat.on_attach })
  end
end
