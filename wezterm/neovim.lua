local wezterm = require 'wezterm'
local smart_splits = wezterm.plugin.require 'https://github.com/mrjones2014/smart-splits.nvim'

local M = {}

M.apply_to_config = function(config)
  smart_splits.apply_to_config(config, {
    direction_keys = { 'h', 'j', 'k', 'j' },
    modifiers = {
      move = 'CTRL',
      resize = 'CTRL|SHIFT',
    },
    log_level = 'info',
  })
end

return M
