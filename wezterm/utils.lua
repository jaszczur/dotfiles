local wezterm = require 'wezterm'

local M = {}

M.is_darwin = function()
  return wezterm.target_triple:find 'darwin' ~= nil
end

M.extend_keys = function(config, keys)
  if config.keys == nil then
    config.keys = {}
  end

  for _, keymap in ipairs(keys) do
    table.insert(config.keys, keymap)
  end

  return config
end

return M
