local wezterm = require 'wezterm';

local config = {
  color_scheme = "Dracula (Official)",
  default_prog = {"fish", "-c", "tmux a || tmux"},
  font = wezterm.font_with_fallback {
    "PTMono Nerd Font",
    "FuraCode Nerd Font Mono",
  },
  font_size = 11.0,
  font_rules = {
	  {
		  italic = true,
		  font = wezterm.font("Operation Mono", {italic=true})
	  },
  },
  freetype_load_target = "Light",
  freetype_render_target = "HorizontalLcd",
  hide_tab_bar_if_only_one_tab = true,
}

return config
