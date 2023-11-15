local wezterm = require 'wezterm';

local config = {
  color_scheme = "Dracula (Official)",
  default_prog = { "fish", "-c", "tmux a || tmux" },
  font = wezterm.font_with_fallback {
    "MonoLisa",
    "FuraCode Nerd Font Mono",
  },
  font_size = 11.0,
  line_height = 0.9,
  freetype_load_target = "Light",
  freetype_render_target = "HorizontalLcd",
  freetype_render_mode = "Subpixel",
  freetype_load_flags = "NO_HINTING",
  hide_tab_bar_if_only_one_tab = true,
}

return config
