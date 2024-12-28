local wezterm = require 'wezterm'
local M = {}

local scheme_for_appearance = function(appearance)
  if appearance:find 'Dark' then
    return 'Catppuccin Macchiato'
  else
    return 'Catppuccin Latte'
  end
end

M.apply_to_config = function(config)
  config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
  config.font = wezterm.font 'IosevkaTerm Nerd Font'
  -- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
  config.font_size = 16.0
  config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }
  config.window_background_opacity = 0.85
  config.macos_window_background_blur = 20
  config.hide_tab_bar_if_only_one_tab = false
  config.use_fancy_tab_bar = false
  config.max_fps = 120
  return config
end

return M
