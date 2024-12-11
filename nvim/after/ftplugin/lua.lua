-- Evaluate
vim.keymap.set('n', '<leader>eb', ':source % <CR>', { desc = 'Eval buffer', buffer = true })
vim.keymap.set('n', '<leader>el', ':.lua <CR>', { desc = 'Eval line', buffer = true })
vim.keymap.set('v', '<leader>er', ':lua <CR>', { desc = 'Eval region', buffer = true })
vim.keymap.set('v', '<leader>ee', ':lua <CR>', { desc = 'Eval region', buffer = true })
