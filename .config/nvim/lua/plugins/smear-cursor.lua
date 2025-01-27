local macchiato = require('catppuccin.palettes').get_palette 'macchiato'
local smear = require('smear_cursor')

smear.setup({

  -- Faster smear
  -- stiffness = 0.8,
  -- trailing_stiffness = 0.5,
  -- distance_stop_animating = 0.5,
  -- hide_target_hack = false,

  cursor_color = macchiato['flamingo'],
  legacy_computing_symbols_support = true,
})
