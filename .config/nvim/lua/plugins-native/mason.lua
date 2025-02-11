-- Languages supported
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
  'ruby_lsp',                        -- Ruby
  'terraformls',                     -- Terraform
  'tflint',                          -- Terraform
  'ts_ls',                           -- TypeScript
}

-- Python-specific overrides
local python_dir;
if vim.env.VIRTUAL_ENV then
  python_dir = vim.env.VIRTUAL_ENV .. "/bin/"
else
  python_dir = "$HOME/.pyenv/versions/3.8.18/bin/"
end
vim.g.python3_host_prog = python_dir .. "python"

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
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "Snacks" },
        },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
          },
        },
      },
    },
  },
  marksman = {
    lint = {
      with = 'markdownlint',
    },
  },
  pylsp = {
    cmd = { python_dir .. "pylsp" },
    plugins = {
      -- formatter options
      black = { enabled = true },
      autopep8 = { enabled = false },
      yapf = { enabled = false },
      -- linter options
      pylint = { enabled = true },
      pyflakes = { enabled = false },
      pycodestyle = { enabled = false },
      -- type checker
      pylsp_mypy = { enabled = true },
      -- auto-completion options
      jedi_completion = { fuzzy = true },
      -- import sorting
      pyls_isort = { enabled = true },
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

return {
  -- https://github.com/williamboman/mason.nvim
  { "williamboman/mason.nvim",       opts = {} },

  -- https://github.com/williamboman/mason-lspconfig.nvim
  {
    "williamboman/mason-lspconfig.nvim",
    opts = { ensure_installed = servers },
  },

  -- https://github.com/lukas-reineke/lsp-format.nvim
  { "lukas-reineke/lsp-format.nvim", opts = { sync = true } },

  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {},
    config = function()
      local lspconfig = require("lspconfig")
      local lspformat = require("lsp-format")

      -- Capture default LSP capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

      -- Setup each LSP
      for _, server in ipairs(servers) do
        local opts = overrides[server] or {}
        if opts.cmd then
          opts = vim.tbl_deep_extend("force", opts, {
            cmd = opts.cmd,
          })
        end
        opts = vim.tbl_deep_extend("force", opts, {
          capabilities = capabilities,
          on_attach = function(client)
            -- Ensure formatting is enabled
            if client.server_capabilities then
              client.server_capabilities.documentFormattingProvider = true
            end
            lspformat.on_attach(client)
          end,
        })
        lspconfig[server].setup(opts)
      end
    end,
  },
}
