-- Neovide
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set('n', '<C-=>', function()
  change_scale_factor(1.25)
end)
vim.keymap.set('n', '<C-->', function()
  change_scale_factor(1 / 1.25)
end)

-- Colemak mappings

local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'x', 'o' }, 'n', 'j', opts)
vim.keymap.set({ 'n', 'x', 'o' }, 'e', 'k', opts)
vim.keymap.set({ 'n', 'x', 'o' }, 'i', 'l', opts)
vim.keymap.set({ 'n', 'x', 'o' }, 'N', 'J', opts)
vim.keymap.set({ 'n', 'x', 'o' }, 'E', 'K', opts)
vim.keymap.set({ 'n', 'x', 'o' }, 'I', 'L', opts)

vim.keymap.set({ 'n', 'x', 'o' }, 'u', 'i', opts)
vim.keymap.set({ 'n', 'x', 'o' }, 'U', 'I', opts)

-- Use t-f-j rotation
vim.keymap.set({ 'n', 'x', 'o' }, 'f', 'e', opts)
vim.keymap.set({ 'n', 'x', 'o' }, 'F', 'E', opts)
vim.keymap.set({ 'n', 'x', 'o' }, 't', 'f', opts)
vim.keymap.set({ 'n', 'x', 'o' }, 'T', 'F', opts)
vim.keymap.set({ 'n', 'x', 'o' }, 'j', 't', opts)
vim.keymap.set({ 'n', 'x', 'o' }, 'J', 'T', opts)

-- Undo/redo
vim.keymap.set('n', 'l', 'u', opts)
vim.keymap.set('n', 'L', 'U', opts)
vim.keymap.set('x', 'l', ':<C-U>undo<CR>', opts)
vim.keymap.set('n', 'gl', 'u', opts)
vim.keymap.set('x', 'gl', ':<C-U>undo<CR>', opts)

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-n>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-e>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-i>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Doomizations ]]
--
-- Buffers
-- vim.keymap.set('n', '<leader>bd', ':e#<bar>bd # <CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>bd', ':Bdelete <CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>bn', ':enew <CR>', { desc = 'New buffer' })
vim.keymap.set('n', '<leader>bp', ':b# <CR>', { desc = '[B]uffer [P]revious' })
vim.keymap.set('n', '<leader><TAB>', ':b# <CR>', { desc = '[B]uffer [P]revious' })

-- Windows
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>wn', '<C-w>j', { desc = 'Move focus to the down window' })
vim.keymap.set('n', '<leader>we', '<C-w>k', { desc = 'Move focus to the up window' })
vim.keymap.set('n', '<leader>wi', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>wr', '<C-w>r', { desc = 'Rotate windows down/right' })
vim.keymap.set('n', '<leader>wR', '<C-w>R', { desc = 'Rotate windows up/left' })
vim.keymap.set('n', '<leader>wd', ':q <CR>', { desc = 'Close current window' })

-- Files
vim.keymap.set('n', '<leader>fs', ':w <CR>', { desc = 'Save file' })

-- Quit
vim.keymap.set('n', '<leader>qq', ':wqa <CR>', { desc = 'Save all and exit' })
