return {
  'MeanderingProgrammer/markdown.nvim',
  name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('render-markdown').setup {
      start_enabled = false,
    }
  end,
  -- disable the plugin so it doesn't conflict with Obsidian
  ft = 'markdown',
  keys = {
    {
      '<localleader>tr',
      function()
        require('render-markdown').toggle()
      end,
      ft = 'markdown',
      desc = '[T]oggle [r]ender',
    },
    {
      '<localleader>n',
      function()
        local timestamp = os.date '%Y%m%d%H%M%S'
        vim.api.nvim_put({ '[[' .. timestamp .. ' ]]' }, '', true, true)
        vim.api.nvim_command ':norm h'
        vim.api.nvim_command ':startinsert'
      end,
      desc = 'Insert link to [n]ew note',
    },
    {
      '<localleader>T',
      function()
        local timestamp = os.date '%Y%m%d%H%M%S'
        vim.api.nvim_put({ '' .. timestamp }, '', true, true)
      end,
      desc = 'Insert surrent timestamp',
    },
  },
}
