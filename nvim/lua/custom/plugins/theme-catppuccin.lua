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
    transparent_background = true,
  },
  init = function()
    local term_theme = os.getenv 'THEME' or 'dark'
    -- local hour = tonumber(os.date('%H', os.time()))
    -- if hour >= 8 and hour < 16 then

    if term_theme == 'light' then
      vim.cmd.colorscheme 'catppuccin-latte'
    else
      vim.cmd.colorscheme 'catppuccin-frappe'
    end
  end,
}
