-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- { 'reasonml-editor/vim-reason-plus', lazy = false },
  {
    'mustache/vim-mustache-handlebars',
    'famiu/bufdelete.nvim',
    'aklt/plantuml-syntax',
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
  },
}
