local wezterm = require 'wezterm'
local workspace_switcher = wezterm.plugin.require 'https://github.com/MLFlexer/smart_workspace_switcher.wezterm'

local M = {}

M.apply_to_config = function(config)
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
end

return M
