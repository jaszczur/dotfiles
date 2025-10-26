return {
  {
    'leath-dub/snipe.nvim',
    event = 'VeryLazy',
    keys = {
      {
        'gb',
        function()
          require('snipe').open_buffer_menu()
        end,
        desc = 'Buffer snipe',
      },
    },
    opts = {},
  },
}
