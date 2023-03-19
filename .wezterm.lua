local wezterm = require 'wezterm';

return {
  color_scheme = "Dracula (Official)",
  default_prog = {"fish", "-c", "tmux a || tmux"},
  enable_tab_bar = false,
  font = wezterm.font_with_fallback {
    "MonoLisa",
    "FuraCode Nerd Font Mono",
  },
  font_size = 10.5,
  font_rules = {
	  {
		  italic = true,
		  font = wezterm.font("MonoLisa", {italic=true})
	  }
  },
  font_antialias = "Greyscale",
  font_hinting = "Full"
}
