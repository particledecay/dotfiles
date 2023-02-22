local nls = require('null-ls')
local code = nls.builtins.code_actions
local cmp = nls.builtins.completion
local diag = nls.builtins.diagnostics
local fmt = nls.builtins.formatting
local hov = nls.builtins.hover
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

nls.setup({
  sources = {
    -- Code Actions
    code.gitrebase,                 -- git
    code.gitsigns,                  -- git
    code.refactoring,               -- refactoring by martin fowler
    code.shellcheck,                -- shell

    -- Diagnostics
    diag.actionlint,                -- github actions
    diag.ansiblelint,               -- ansible
    diag.curlylint,                 -- HTML template linting
    diag.djlint,                    -- django
    diag.eslint_d,                  -- javascript
    diag.fish,                      -- fish
    diag.flake8,                    -- python
    diag.jsonlint,                  -- json
    diag.semgrep.with {             -- semgrep
      args = { "-q", "--config=auto", "$FILENAME" },
    },
    diag.shellcheck,                -- shell
    diag.staticcheck,               -- go
    diag.todo_comments,             -- todos
    diag.vulture,                   -- find unused python code

    -- Formatting
    fmt.autopep8,                   -- python
    fmt.eslint_d,                   -- javascript
    fmt.fish_indent,                -- fish
    fmt.gofmt,                      -- go
    fmt.goimports,                  -- go imports
    fmt.isort,                      -- python imports
    fmt.jq,                         -- json
    fmt.prettierd,                  -- javascript
    fmt.terraform_fmt.with {        -- terraform
      filetypes = { "terraform", "tf", "hcl" },
    },
    fmt.trim_newlines,              -- trailing newlines
    fmt.trim_whitespace,            -- trailing whitespace

    -- Hover
    hov.printenv,                   -- show environment variable values
  },

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
})
