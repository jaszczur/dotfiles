local M = {}

local action = (require 'wezterm').action

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
    { key = '[', mods = 'LEADER', action = action.ActivateCopyMode },
  }

  if config.keys == nil then
    config.keys = keys
  else
    for _, keymap in ipairs(keys) do
      table.insert(config.keys, keymap)
    end
  end

  return config
end

return M
