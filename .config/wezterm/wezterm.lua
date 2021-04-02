local wezterm = require 'wezterm';

return {
  color_scheme = "OneHalfDark",
  font = wezterm.font("MonoLisa"),
  font_size = 12.0,
  font_rules = {
	  {
		  italic = true,
		  font = wezterm.font("MonoLisa", {italic=true})
	  }
  },
  font_antialias = "Greyscale",
  font_hinting = "Full"
}
