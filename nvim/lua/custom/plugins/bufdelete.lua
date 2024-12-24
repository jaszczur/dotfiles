return {
  {
    'famiu/bufdelete.nvim',
    config = function()
      vim.keymap.set('n', '<leader>bd', ':Bdelete <CR>', { desc = 'Close buffer' })
    end,
  },
}
