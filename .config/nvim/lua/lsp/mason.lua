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
  'ruby_lsp',                        -- Ruby
  'terraformls',                     -- Terraform
  'tflint',                          -- Terraform
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
  biome = {
    root_dir = function(fname)
      return lspconfig.util.root_pattern('.git', '.biome')(fname) or lspconfig.util.find_git_ancestor(fname) or
          lspconfig.util.path.dirname(fname)
    end,
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
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
      },
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
}

mason.setup()
masonlsp.setup({ ensure_installed = servers })
lspformat.setup({ sync = true })

-- capabilities and formatter
local caps_and_format = {
  capabilities = {
    ["workspace/didChangeWatchedFiles"] = {
      dynamicRegistration = true,
    },
  },
  on_attach = lspformat.on_attach,
}

-- set up the language servers
for _, server in ipairs(servers) do
  -- initialize each language server with override settings if found
  if overrides[server] then
    lspconfig[server].setup(vim.tbl_deep_extend('force', overrides[server], caps_and_format))
  else
    lspconfig[server].setup(caps_and_format)
  end
end
