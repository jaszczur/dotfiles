return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {}
    local map = vim.keymap.set

    map('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = '[H]arpoon [a]dd' })

    map('n', '<leader>hh', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[H]arpoon list' })

    map('n', '<leader>h1', function()
      harpoon:list():select(1)
    end, { desc = '[H]arpoon 1' })
    map('n', '<leader>h2', function()
      harpoon:list():select(2)
    end, { desc = '[H]arpoon 2' })
    map('n', '<leader>h3', function()
      harpoon:list():select(3)
    end, { desc = '[H]arpoon 3' })
    map('n', '<leader>h4', function()
      harpoon:list():select(4)
    end, { desc = '[H]arpoon 4' })

    -- Toggle previous & next buffers stored within Harpoon list
    map('n', '<leader>hp', function()
      harpoon:list():prev()
    end, { desc = '[H]arpoon [p]revious' })
    map('n', '<leader>hn', function()
      harpoon:list():next()
    end, { desc = '[H]arpoon [n]ext' })
  end,
}
