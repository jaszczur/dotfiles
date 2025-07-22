return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- 'github/copilot.vim',
      {
        'ravitemer/mcphub.nvim',
        dependencies = {
          'nvim-lua/plenary.nvim',
        },
        -- build = 'pnpm install -g mcp-hub@latest',
        build = 'bundled_build.lua',
        -- config = function()
        --   require('mcphub').setup()
        -- end,
        opts = {
          use_bundled_binary = true,
        },

        keys = {
          {
            '<leader>am',
            ':MCPHub<CR>',
            desc = '[A]I [M]CP Hub',
          },
        },
      },
    },
    keys = {
      {
        '<leader>aa',
        ':CodeCompanionActions<CR>',
        desc = '[A]I [a]ctions',
      },
      {
        '<leader>ac',
        ':CodeCompanionChat<CR>',
        desc = '[A]I [c]hat',
      },
      {
        '<leader>ap',
        ':CodeCompanion<CR>',
        desc = '[A]I [p]rompt',
      },
      {
        '<leader>ai',
        ':CodeCompanion ',
        desc = '[A]I [p]rompt',
        mode = { 'v', 'x' },
      },
    },
    opts = {
      strategies = {
        -- Change the default chat adapter
        chat = {
          adapter = 'copilot',
          model = 'claude-3.7-sonnet',
        },
        inline = {
          adapter = 'copilot',
        },
      },
      opts = {
        -- Set debug logging
        log_level = 'DEBUG',
      },
      display = {
        action_palette = {
          provider = 'telescope',
          opts = {
            show_default_actions = true,
            show_default_prompt_library = true,
          },
        },
      },
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            show_result_in_chat = true,
            make_vars = true,
            make_slash_commands = true,
          },
        },
      },
    },
  },
}
