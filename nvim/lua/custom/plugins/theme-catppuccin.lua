return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = {
    -- color_overrides = {
    --   latte = {
    --     overlay0 = '#6d738c',
    --   },
    -- },
    integrations = {
      neotree = true,
      which_key = true,
      mini = {
        enabled = true,
      },
    },
  },
  init = function()
    -- local hour = tonumber(os.date('%H', os.time()))
    -- if hour >= 8 and hour < 16 then
    --   vim.cmd.colorscheme 'catppuccin-latte'
    vim.cmd.colorscheme 'catppuccin-frappe'
  end,
}
