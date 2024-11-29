return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  keys = {
    {
      '<leader>of',
      function()
        require('oil').toggle_float()
      end,
      desc = '[O]pen [f]ile explorer',
    },
  },
}
