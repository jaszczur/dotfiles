local wezterm = require 'wezterm'
local M = {}

local opacity = 0.9

local scheme_for_appearance = function(appearance)
  if appearance:find 'Dark' then
    return 'Catppuccin Macchiato'
  else
    return 'Catppuccin Latte'
  end
end

local font_for_appearance = function(appearance)
  if appearance:find 'Dark' then
    return wezterm.font { family = 'IosevkaTerm Nerd Font', weight = 'Regular' }
  else
    return wezterm.font { family = 'IosevkaTerm Nerd Font', weight = 'Medium' }
  end
end

local toggle_transparency_command = {
  brief = 'Toggle transparency',
  icon = 'md_circle_opacity',
  action = wezterm.action_callback(function(window)
    local overrides = window:get_config_overrides() or {}

    if overrides.window_background_opacity == 1.0 then
      overrides.window_background_opacity = opacity
    else
      overrides.window_background_opacity = 1.0
    end

    window:set_config_overrides(overrides)
  end),
}

M.apply_to_config = function(config)
  local appearance = wezterm.gui.get_appearance()
  config.color_scheme = scheme_for_appearance(appearance)
  config.font = font_for_appearance(appearance)
  -- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' } -- disable ligatures
  config.font_size = 16.0
  config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }
  config.window_background_opacity = opacity
  config.macos_window_background_blur = 20
  config.hide_tab_bar_if_only_one_tab = false
  config.use_fancy_tab_bar = false
  config.max_fps = 120

  wezterm.on('augment-command-palette', function()
    return { toggle_transparency_command }
  end)

  return config
end

return M
