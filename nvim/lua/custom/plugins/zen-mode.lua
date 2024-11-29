return {
  'folke/zen-mode.nvim',
  keys = {
    {
      '<leader>tz',
      ':ZenMode<CR>',
      desc = '[T]oggle [z]en mode',
    },
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    plugins = {
      alacritty = {
        enabled = not vim.g.neovide,
        font = '20',
      },
      tmux = {
        enabled = not vim.g.neovide,
      },
    },
  },
}
