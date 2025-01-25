local conform = require('conform')

-- setup some formatters by filetype
conform.setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'isort', 'black' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
  format_after_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 1000, lsp_fallback = true, async = true }
  end,
})

-- python overrides
conform.formatters.black = {
  prepend_args = { '--line-length', '100' },
}
