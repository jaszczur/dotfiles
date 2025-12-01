return {
  -- {
  --   'ggandor/leap.nvim',
  --   config = function()
  --     -- local leap = require 'leap'
  --     -- leap.opts.safe_labels = 'rstnei/RSTNEI'
  --
  --     vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
  --     vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
  --     -- vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)')
  --   end,
  -- },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      -- labels = 'tnseriaodhkbmvcxzlpufywjgq',
      modes = {
        search = {
          enabled = false,
        },
        char = {
          keys = {
            'f',
            'F',
            't',
            'T',
            [';'] = ';',
            [','] = '\\',
          },
        },
      },
    },
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
}
