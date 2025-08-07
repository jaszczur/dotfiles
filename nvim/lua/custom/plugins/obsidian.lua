-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
local home = vim.fn.expand '~'
local obsidian_base = home .. '/Sync/obsidian'
local obsidian_files = obsidian_base .. '/**.md'

return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    'BufReadPre ' .. obsidian_files,
    'BufNewFile ' .. obsidian_files,
    'VeryLazy', -- load it anyway
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'nvim-telescope/telescope.nvim',
    'folke/snacks.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'notes',
        path = obsidian_base,
      },
    },
    daily_notes = {
      folder = 'journal',
      template = 'daily.md',
    },
    templates = {
      folder = 'templates',
    },
    notes_subdir = 'inbox',
    new_notes_location = 'notes_subdir',
    preferred_link_style = 'wiki',
    attachments = {
      img_folder = 'attachments',
    },
    completion = {
      nvim_cmp = false,
      blink = true,
    },
    picker = {
      name = 'snacks.pick',
    },

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ''
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        -- suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        suffix = title:gsub('[^A-Za-z0-9 -ŻÓŁĆĄŹŃżółćąźń]', '')
        -- suffix = title:gsub('[%c%p]', '')
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        suffix = 'raw '
        for _ = 1, 4 do
          suffix = '' .. string.char(math.random(65, 90))
        end
      end
      return os.date '%Y%m%d%H%M%S' .. ' ' .. suffix
    end,
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      if vim.loop.os_uname().sysname == 'Darwin' then
        vim.fn.jobstart { 'open', url } -- Mac OS
      else
        vim.fn.jobstart { 'xdg-open', url } -- Linux
      end
    end,
  },

  keys = {
    {
      '<leader>nn',
      ':ObsidianNew<CR>',
      desc = '[n]ew note',
    },
    {
      '<leader>nt',
      ':ObsidianToday<CR>',
      desc = '[t]oday note',
    },
    {
      '<leader>ny',
      ':ObsidianYesterday<CR>',
      desc = '[y]esterday note',
    },
    {
      '<leader>nm',
      ':ObsidianTomorrow<CR>',
      desc = 'To[m]morow note',
    },
    {
      '<leader>ns',
      ':ObsidianSearch<CR>',
      desc = '[s]earch notes',
    },
    {
      '<localleader>tc',
      function()
        require('obsidian').util.toggle_checkbox()
      end,
      desc = '[t]oggle [c]heckbox',
      ft = 'markdown',
    },
    {
      '<localleader>T',
      ':ObsidianTags<CR>',
      desc = '[T]ags',
      ft = 'markdown',
    },
    {
      '<localleader>b',
      ':ObsidianBacklinks<CR>',
      desc = '[b]acklinks to current note',
      ft = 'markdown',
    },
    {
      '<localleader>l',
      ':ObsidianLinks<CR>',
      desc = '[l]inks in current note',
      ft = 'markdown',
    },
    {
      '<localleader>o',
      ':ObsidianOpen<CR>',
      desc = '[o]pen in Obsidian app',
      ft = 'markdown',
    },
  },
}
