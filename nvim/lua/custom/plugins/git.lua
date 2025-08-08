return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      'folke/snacks.nvim', -- optional
    },
    config = true,
    keys = {
      {
        '<leader>gg',
        function()
          require('neogit').open {}
        end,
        desc = 'Git status',
      },
    },
  },
}
