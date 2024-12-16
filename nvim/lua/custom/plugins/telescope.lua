-- Slightly advanced example of overriding default behavior and theme
local find_in_curr_buff = function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end

local live_grep_opened_files = function()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

-- Search project files
local live_grep_from_project_git_root = function()
  local function is_git_repo()
    vim.fn.system 'git rev-parse --is-inside-work-tree'

    return vim.v.shell_error == 0
  end

  local get_git_root = function()
    local dot_git_path = vim.fn.finddir('.git', '.;')
    return vim.fn.fnamemodify(dot_git_path, ':h')
  end

  local opts = {}

  if is_git_repo() then
    opts = {
      cwd = get_git_root(),
    }
  end

  require('telescope.builtin').live_grep(opts)
end

local search_neovim_config = function()
  require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
end

--
-- Live multigrep from "Advent of Neovim"
--
local live_multigrep_command = function(prompt)
  if not prompt or prompt == '' then
    return nil
  end

  local pieces = vim.split(prompt, '  ')
  local args = { 'rg' }

  if pieces[1] then
    table.insert(args, '-e')
    table.insert(args, pieces[1])
  end

  if pieces[2] then
    table.insert(args, '-g')
    table.insert(args, pieces[2])
  end

  return vim
    .iter({
      args,
      { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
    })
    :flatten()
    :totable()
end

local live_multigrep = function(opts)
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = live_multigrep_command,
    entry_maker = require('telescope.make_entry').gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers
    .new(opts, {
      finder = finder,
      prompt_title = 'Grep project files, filter by filename glob',
      debounce = 100,
      previewer = require('telescope.config').values.grep_previewer(opts),
      sorter = require('telescope.sorters').empty(),
    })
    :find()
end

return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    --
    -- Hidden files search configured as in
    -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#file-and-text-search-in-hidden-files-and-directories

    local telescopeConfig = require 'telescope.config'
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, '--hidden')
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, '--glob')
    table.insert(vimgrep_arguments, '!**/.git/*')

    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      defaults = {
        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sS', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', live_multigrep, { desc = '[S]earch by [G]rep with fname glob' })
    vim.keymap.set('n', '<leader>sG', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = 'Find existing [B]uffers' })
    vim.keymap.set('n', '<leader>ht', builtin.colorscheme, { desc = 't[H]eme [T]oggle' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ile [F]ind' })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[R]ecent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>pf', builtin.git_files, { desc = '[P]roject [F]iles ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.commands, { desc = 'Vim commands' })
    vim.keymap.set('n', '<leader>/', find_in_curr_buff, { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set('n', '<leader>ss', find_in_curr_buff, { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set('n', '<leader>s/', live_grep_opened_files, { desc = '[S]earch [/] in Open Files' })
    vim.keymap.set('n', '<leader>sn', search_neovim_config, { desc = '[S]earch [N]eovim files' })
    vim.keymap.set('n', '<leader>sp', live_grep_from_project_git_root, { desc = '[S]earch [p]roject files' })
  end,
}
