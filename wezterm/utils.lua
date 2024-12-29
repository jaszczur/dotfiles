local wezterm = require 'wezterm'

local M = {}

M.is_darwin = function()
  return wezterm.target_triple:find 'darwin' ~= nil
end

return M
