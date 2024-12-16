return {
  {
    'NeogitOrg/neogit',
    config = true,
    keys = {
      {
        '<leader>gg',
        function()
          require('neogit').open {}
        end,
        desc = 'Git status',
      },
      {
        '<leader>gs',
        function()
          require('neogit').open {}
        end,
        desc = 'Git status',
      },
      {
        '<leader>gc',
        function()
          require('neogit').open {}
        end,
        desc = 'Git commit',
      },
    },
  },
}
