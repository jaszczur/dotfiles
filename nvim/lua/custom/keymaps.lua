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

-- local opts = { noremap = true, silent = true }
--
-- vim.keymap.set({ 'n', 'x', 'o' }, 'n', 'j', opts)
-- vim.keymap.set({ 'n', 'x', 'o' }, 'e', 'k', opts)
-- vim.keymap.set({ 'n', 'x', 'o' }, 'i', 'l', opts)
-- vim.keymap.set({ 'n', 'x', 'o' }, 'N', 'J', opts)
-- vim.keymap.set({ 'n', 'x', 'o' }, 'E', 'K', opts)
-- vim.keymap.set({ 'n', 'x', 'o' }, 'I', 'L', opts)
--
-- vim.keymap.set({ 'n', 'x', 'o' }, 'u', 'i', opts)
-- vim.keymap.set({ 'n', 'x', 'o' }, 'U', 'I', opts)
--
-- -- Use t-f-j rotation
-- vim.keymap.set({ 'n', 'x', 'o' }, 'f', 'e', opts)
-- vim.keymap.set({ 'n', 'x', 'o' }, 'F', 'E', opts)
-- vim.keymap.set({ 'n', 'x', 'o' }, 't', 'f', opts)
-- vim.keymap.set({ 'n', 'x', 'o' }, 'T', 'F', opts)
-- vim.keymap.set({ 'n', 'x', 'o' }, 'j', 't', opts)
-- vim.keymap.set({ 'n', 'x', 'o' }, 'J', 'T', opts)
--
-- -- Undo/redo
-- vim.keymap.set('n', 'l', 'u', opts)
-- vim.keymap.set('n', 'L', 'U', opts)
-- vim.keymap.set('x', 'l', ':<C-U>undo<CR>', opts)
-- vim.keymap.set('n', 'gl', 'u', opts)
-- vim.keymap.set('x', 'gl', ':<C-U>undo<CR>', opts)

--  See `:help wincmd` for a list of all window commands
--  Now managed by smart-splits plugin
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-n>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-e>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-i>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Doomizations ]]

-- Top level menu
-- vim.keymap.set({ 'n', 't' }, '<leader>!', ':Floaterminal <CR>', { desc = 'Open terminal' })
-- vim.keymap.set({ 'n', 't' }, '<leader>tt', ':Floaterminal <CR>', { desc = 'Toggle terminal' })

-- Buffers
-- vim.keymap.set('n', '<leader>bd', ':e#<bar>bd # <CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>bn', ':enew <CR>', { desc = 'New buffer' })
vim.keymap.set('n', '<leader>bp', ':b# <CR>', { desc = '[B]uffer [P]revious' })
vim.keymap.set('n', '<leader><TAB>', ':b# <CR>', { desc = '[B]uffer [P]revious' })

-- Code
vim.keymap.set('n', '<leader>cq', ':clist <CR>', { desc = 'Open [Q]uickfix list' })
vim.keymap.set('n', '<leader>cn', ':cnext <CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '<leader>cp', ':cprev <CR>', { desc = 'Previous quickfix item' })
vim.keymap.set('n', '<leader>ce', ':cprev <CR>', { desc = 'Previous quickfix item' })

-- Lazy
vim.keymap.set('n', '<leader>ll', ':Lazy show<CR>', { desc = '[L]azy show' })
vim.keymap.set('n', '<leader>lu', ':Lazy update<CR>', { desc = '[L]azy [u]pdate' })
vim.keymap.set('n', '<leader>lu', ':Lazy sync<CR>', { desc = '[L]azy [s]ync' })

-- Windows
vim.keymap.set('n', '<leader>ws', ':split <CR>', { desc = 'New window below' })
vim.keymap.set('n', '<leader>wv', ':vsplit <CR>', { desc = 'New window right' })

vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = 'Move focus to the down window' })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = 'Move focus to the up window' })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = 'Move focus to the right window' })

vim.keymap.set('n', '<leader>wH', '<C-w>H', { desc = 'Move window to left' })
vim.keymap.set('n', '<leader>wJ', '<C-w>J', { desc = 'Move window down' })
vim.keymap.set('n', '<leader>wK', '<C-w>K', { desc = 'Move window up' })
vim.keymap.set('n', '<leader>wL', '<C-w>L', { desc = 'Move window to right' })

vim.keymap.set('n', '<leader>wr', '<C-w>r', { desc = 'Rotate windows down/right' })
vim.keymap.set('n', '<leader>wR', '<C-w>R', { desc = 'Rotate windows up/left' })

vim.keymap.set('n', '<leader>wd', ':q <CR>', { desc = 'Close current window' })

-- Files
vim.keymap.set('n', '<leader>fs', ':w <CR>', { desc = 'Save file' })

-- Quit
vim.keymap.set('n', '<leader>qq', ':wqa <CR>', { desc = 'Save all and exit' })
vim.keymap.set('n', '<leader>qQ', ':qa! <CR>', { desc = 'Exit without saving' })
