return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  priority = 900,
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = { timeout_ms = 500 },
    formatters = {
      black = {
        prepend_args = { "--line-length", "110" },
      },
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
  config = function(plugin)
    require("conform").setup(plugin.opts)

    -- Extract all filetypes that Conform is handling
    _G.conform_filetypes = {}
    for ft, _ in pairs(plugin.opts.formatters_by_ft or {}) do
      _G.conform_filetypes[ft] = true
    end
  end,
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
