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
  'pyright',                         -- Python
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
    settings = {
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
  },
  gopls = {
    settings = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      vulncheck = true,
    },
  },
  helm_ls = {
    settings = {
      lint = {
        with = 'helm',
      },
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
    settings = {
      lint = {
        with = 'markdownlint',
      },
    },
  },
  pyright = {
    cmd = { python_dir .. "pyright-langserver", "--stdio" },
    settings = {
      python = {
        analysis = {
          diagnosticMode = "workspace",
          typeCheckingMode = "basic",
          autoImportCompletions = true,
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
        pythonPath = vim.g.python3_host_prog,
      },
    },
  },
  terraformls = {
    settings = {
      filetypes = { 'terraform', 'terraform-vars', 'tf', 'hcl' },
      format = {
        args = { 'fmt', '-' },
        command = 'terraform',
        stdin = true,
      },
    },
  },
}

return {
  -- https://github.com/williamboman/mason.nvim
  {
    "williamboman/mason.nvim",
    dependencies = { "stevearc/conform.nvim" },
    opts = {}
  },

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
        opts = vim.tbl_extend("force", opts, {
          capabilities = capabilities,
          on_attach = function(client)
            -- Ensure formatting is enabled
            if client.server_capabilities then
              client.server_capabilities.documentFormattingProvider = true
            end
            -- If Conform is handling this filetype, disable formatting
            if _G.conform_filetypes[vim.bo.filetype] then
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            else
              lspformat.on_attach(client)
            end
          end,
        })
        lspconfig[server].setup(opts)
      end
    end,
  },
}
