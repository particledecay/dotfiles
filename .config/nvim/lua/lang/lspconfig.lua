local nls = require('null-ls')
local code = nls.builtins.code_actions
local diag = nls.builtins.diagnostics
local fmt = nls.builtins.formatting
local hov = nls.builtins.hover
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

nls.setup({
  sources = {
    code.gitrebase,
    code.gitsigns,
    code.shellcheck,

    diag.actionlint,
    diag.ansiblelint,
    diag.djlint,
    diag.eslint_d,
    diag.fish,
    diag.flake8,
    diag.jsonlint,
    -- diag.revive,
    diag.shellcheck,
    diag.todo_comments,
    diag.vulture,

    fmt.autopep8,
    fmt.eslint_d,
    fmt.fish_indent,
    -- fmt.gofmt,
    -- fmt.goimports,
    fmt.isort,
    fmt.jq,
    fmt.prettierd,
    fmt.terraform_fmt.with {
      filetypes = { "terraform", "tf", "hcl" },
    },
    fmt.trim_newlines,
    fmt.trim_whitespace,

    hov.printenv,
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
