-- disable Tab as the accept key
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
-- vim.g.copilot_tab_fallback = ""

-- enable specific languages
vim.g.copilot_filetypes = {
  python = true,
  go = true,
  javascript = true,
  typescript = true,
  typescriptreact = true,
  html = true,
  css = true,
  scss = true,
  markdown = true,
  yaml = true,
  json = true,
  lua = true,
  rust = true,
  ruby = true,
  sql = true,
  graphql = true,
  docker = true,
  shell = true,
  vim = true,
  xml = true,
  fish = true,
}

require('copilot').setup({
  panel = {
    enabled = false,
    keymap = {
      accept = '<Right>',
    },
  },
  suggestion = {
    enabled = false,
    auto_trigger = true,
    keymap = {
      accept = '<Right>',
      accept_word = false,
      accept_line = false,
    },
  },
  filetypes = vim.g.copilot_filetypes,
  copilot_node_command = 'node',
  server_opts_overrides = {
    settings = {
      advanced = {
        inlineSuggestCount = 1,
      },
    },
  },
})

-- map accept to another key
vim.keymap.set('i', '<Right>', 'copilot#Accept("<CR>")',
  { expr = true, silent = true, noremap = true, replace_keycodes = false })
vim.keymap.set('i', '<C-Down>', '<Plug>(copilot-next)', { silent = true, noremap = true })
vim.keymap.set('i', '<C-Up>', '<Plug>(copilot-previous)', { silent = true, noremap = true })
