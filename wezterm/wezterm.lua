-- Pull in the wezterm API
local wezterm = require 'wezterm'
local action = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Apperance
local scheme_for_appearance = function(appearance)
  if appearance:find 'Dark' then
    return 'Catppuccin Macchiato'
  else
    return 'Catppuccin Latte'
  end
end
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.font = wezterm.font 'IosevkaTerm Nerd Font'
config.font_size = 16.0
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_background_opacity = 0.90
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false

-- Default shell
config.default_prog = { '/etc/profiles/per-user/jaszczur/bin/zsh', '-c', '/run/current-system/sw/bin/nu' }

-- Keybindings
config.leader = { key = 'a', mods = 'CTRL' }
config.keys = {
  {
    key = '"',
    mods = 'LEADER',
    action = action.SplitVertical { domain = 'CurrentPaneDomain' },
  },

  {
    key = '%',
    mods = 'LEADER',
    action = action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = action.SpawnTab 'CurrentPaneDomain',
  },

  {
    key = 'p',
    mods = 'LEADER',
    action = action.ActivateTabRelative(-1),
  },
  {
    key = 'n',
    mods = 'LEADER',
    action = action.ActivateTabRelative(1),
  },
  { key = '[', mods = 'LEADER', action = action.ActivateCopyMode },
}

-- Neovim integration setup
local smart_splits = wezterm.plugin.require 'https://github.com/mrjones2014/smart-splits.nvim'
-- you can put the rest of your Wezterm config here
smart_splits.apply_to_config(config, {
  -- the default config is here, if you'd like to use the default keys,
  -- you can omit this configuration table parameter and just use
  -- smart_splits.apply_to_config(config)

  -- directional keys to use in order of: left, down, up, right
  direction_keys = { 'h', 'n', 'e', 'i' },
  -- if you want to use separate direction keys for move vs. resize, you
  -- can also do this:
  -- direction_keys = {
  --   move = { 'h', 'j', 'k', 'l' },
  --   resize = { 'LeftArrow', 'DownArrow', 'UpArrow', 'RightArrow' },
  -- },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = 'CTRL', -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = 'META', -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
  -- log level to use: info, warn, error
  log_level = 'info',
})

-- Session manager
local workspace_switcher = wezterm.plugin.require 'https://github.com/MLFlexer/smart_workspace_switcher.wezterm'
workspace_switcher.apply_to_config(config)
local on_workspace_updated = function(window, workspace)
  local gui_win = window:gui_window()
  local base_path = string.gsub(workspace, '(.*[/\\])(.*)', '%2')
  gui_win:set_right_status(wezterm.format {
    { Foreground = { Color = '#a6da95' } },
    { Text = '  ' .. base_path .. '  ' },
  })
end
wezterm.on('smart_workspace_switcher.workspace_switcher.chosen', on_workspace_updated)
wezterm.on('smart_workspace_switcher.workspace_switcher.created', on_workspace_updated)

-- and finally, return the configuration to wezterm
return config
