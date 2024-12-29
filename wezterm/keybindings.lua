local action = (require 'wezterm').action
local utils = require 'utils'
local M = {}

local activate_tab_keybinding = function(tab_num)
  return {
    key = tostring(tab_num),
    mods = 'LEADER',
    action = action.ActivateTab(tab_num - 1),
  }
end

M.apply_to_config = function(config)
  config.leader = { key = 'a', mods = 'CTRL' }

  local keys = {
    {
      key = '"',
      mods = 'LEADER|SHIFT',
      action = action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = '%',
      mods = 'LEADER|SHIFT',
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
    {
      key = 'z',
      mods = 'LEADER',
      action = action.TogglePaneZoomState,
    },
    { key = '[', mods = 'LEADER', action = action.ActivateCopyMode },
  }

  for i = 1, 9 do
    table.insert(keys, activate_tab_keybinding(i))
  end

  utils.extend_keys(config, keys)

  return config
end

return M
