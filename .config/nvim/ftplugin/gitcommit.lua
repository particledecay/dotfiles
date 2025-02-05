local cmp = require("blink.cmp")

cmp.setup.buffer({
  sources = {
    { name = "buffer" },
    { name = "conventional_commits" },
  },
})

-- Define Conventional Commit completion source
cmp.register_source("conventional_commits", {
  complete = function(_, callback)
    callback({
      items = {
        { label = "feat: " }, { label = "fix: " }, { label = "chore: " },
        { label = "docs: " }, { label = "style: " }, { label = "refactor: " },
        { label = "test: " }, { label = "perf: " }, { label = "ci: " },
        { label = "build: " }, { label = "revert: " }
      },
    })
  end,
})

-- Abbreviation for BREAKING CHANGE:
vim.cmd("inoreabbrev <buffer> BB BREAKING CHANGE:")

-- Git commit template
vim.opt_local.textwidth = 110
vim.opt_local.formatoptions:append("t") -- Auto-wrap text
