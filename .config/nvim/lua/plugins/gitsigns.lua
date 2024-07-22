-- [lewis6991/gitsigns.nvim] options
require('gitsigns').setup {
  _on_attach_pre = function(_, callback)
    require('gitsigns-yadm').yadm_signs(callback)
  end,
  current_line_blame = false,
}
