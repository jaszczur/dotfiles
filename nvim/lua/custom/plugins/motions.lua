return {
  {
    'ggandor/leap.nvim',
    config = function()
      -- local leap = require 'leap'
      -- leap.opts.safe_labels = 'rstnei/RSTNEI'

      vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
      -- vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)')
    end,
  },
}
