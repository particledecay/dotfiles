-- [nvim-tree/nvim-tree.lua]
require('nvim-tree').setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
    side = "left",
    number = true,
    relativenumber = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    group_empty = true,
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  filters = {
    dotfiles = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
})
-- [nvim-tree/nvim-tree.lua] use ctrl+n for toggling file tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true })
-- [nvim-tree/nvim-tree.lua] use <leader>+ctrl+n for finding file
vim.api.nvim_set_keymap('n', '<leader><C-n>', ':NvimTreeFindFile<CR>', { noremap = true })
