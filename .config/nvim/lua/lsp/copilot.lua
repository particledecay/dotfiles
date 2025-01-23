-- disable Tab as the accept key
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
-- vim.g.copilot_tab_fallback = ""

-- enable specific languages
vim.g.copilot_filetypes = {
  css = true,
  docker = true,
  fish = true,
  go = true,
  graphql = true,
  html = true,
  javascript = true,
  javsscriptreact = true,
  json = true,
  lua = true,
  markdown = true,
  python = true,
  ruby = true,
  rust = true,
  scss = true,
  shell = true,
  sql = true,
  terraform = true,
  typescript = true,
  typescriptreact = true,
  vim = true,
  xml = true,
  yaml = true,
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
