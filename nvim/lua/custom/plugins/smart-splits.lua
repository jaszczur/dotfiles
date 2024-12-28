return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  config = function()
    local smart_splits = require 'smart-splits'
    smart_splits.setup {
      default_amount = 5,
    }
    local keymap = vim.keymap

    keymap.set('n', '<C-h>', smart_splits.move_cursor_left)
    keymap.set('n', '<C-n>', smart_splits.move_cursor_down)
    keymap.set('n', '<C-e>', smart_splits.move_cursor_up)
    keymap.set('n', '<C-i>', smart_splits.move_cursor_right)

    keymap.set('n', '<C-S-h>', smart_splits.resize_left)
    keymap.set('n', '<C-S-n>', smart_splits.resize_down)
    keymap.set('n', '<C-S-e>', smart_splits.resize_up)
    keymap.set('n', '<C-S-i>', smart_splits.resize_right)
  end,
}
