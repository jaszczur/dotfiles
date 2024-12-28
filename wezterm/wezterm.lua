-- Pull in the wezterm API
local wezterm = require 'wezterm'

local apperance = require 'apperance'
local keybindings = require 'keybindings'
local neovim = require 'neovim'
local workspaces = require 'workspaces'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Default shell
-- I don't want to use nushell as default login shell (mainly b/c of lack of some glue code, ie. for setting up Nix). That's why I'm starting nu inside zsh - 💩 but works.
config.default_prog = { '/etc/profiles/per-user/jaszczur/bin/zsh', '-c', '/run/current-system/sw/bin/nu' }

-- Apperance
apperance.apply_to_config(config)

-- Keybindings
keybindings.apply_to_config(config)

-- Neovim integration setup
neovim.apply_to_config(config)

-- Workspace manager
workspaces.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config
