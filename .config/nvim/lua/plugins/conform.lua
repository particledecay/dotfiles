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
})

-- python overrides
conform.formatters.black = {
  prepend_args = { '--line-length', '100' },
}
