return {
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-completion',
  {
    'kristijanhusak/vim-dadbod-ui',
    keys = {
      {
        '<leader>od',
        ':DBUIToggle<CR>',
        desc = '[O]pen [d]atabase',
      },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = vim.g.have_nerd_font
    end,
  },
}
