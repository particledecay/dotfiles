local wezterm = require 'wezterm';

local config = {
  adjust_window_size_when_changing_font_size = false,
  check_for_updates = false,
  color_scheme = "Dracula (Official)",
  default_prog = { "fish", "-c", "tmux a || tmux" },
  font = wezterm.font {
    family = "PTMono Nerd Font",
    -- harfbuzz_features = { "liga=0" },
  },
  font_size = 10.5,
  initial_rows = 55,
  initial_cols = 180,
  -- initial_rows = 50,
  -- initial_cols = 170,
  line_height = 1.1,
  freetype_load_target = "HorizontalLcd",
  freetype_render_target = "HorizontalLcd",
  freetype_load_flags = "NO_HINTING",
  hide_tab_bar_if_only_one_tab = true,
}

return config
