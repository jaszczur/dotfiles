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
    },
  },
}
