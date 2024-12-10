-- Evaluate
vim.keymap.set('n', '<leader>eb', ':source % <CR>', { desc = 'Eval buffer' })
vim.keymap.set('n', '<leader>el', ':.lua <CR>', { desc = 'Eval line' })
vim.keymap.set('v', '<leader>er', ':lua <CR>', { desc = 'Eval region' })
vim.keymap.set('v', '<leader>ee', ':lua <CR>', { desc = 'Eval region' })
