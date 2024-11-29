-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
    { '<leader>op', ':Neotree reveal<CR>', { desc = '[O]pen [P]roject tree' } },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['q'] = 'close_window',
          ['<leader>op'] = 'close_window',
          ['<TAB>'] = 'open',
          -- use Colemak up/down for n & e
          ['n'] = 'noop',
          ['e'] = 'noop',
        },
      },
    },
  },
}
