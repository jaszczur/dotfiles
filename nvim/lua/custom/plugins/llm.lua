return {
  {
    'robitx/gp.nvim',
    config = function()
      local conf = {
        -- required openai api key (string or table with command and arguments)
        -- openai_api_key = { "cat", "path_to/openai_api_key" },
        -- openai_api_key = { "bw", "get", "password", "OPENAI_API_KEY" },
        -- openai_api_key: "sk-...",
        -- openai_api_key = os.getenv("env_name.."),
        providers = {
          openai = {
            disable = false,
            secret = { 'nu', '-c', 'use authinfo.nu; authinfo password api.openai.com' },
          },
          googleai = { disable = true },
          ollama = { disable = false },
        },
        agents = {
          { name = 'ChatOllamaLlama3.1-8B', disable = true },
          { name = 'CodeOllamaLlama3.1-8B', disable = true },
          {
            provider = 'ollama',
            name = 'ChatOllamaDeepseekR1',
            chat = true,
            command = false,
            model = {
              model = 'deepseek-r1:14b',
              temperature = 0.6,
            },
            system_prompt = '',
          },
        },
        chat_shortcut_respond = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-c><C-c>' },
        chat_shortcut_delete = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-c>d' },
        chat_shortcut_stop = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-c>s' },
        chat_shortcut_new = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-c>c' },
      }
      require('gp').setup(conf)

      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
      require('which-key').add {
        -- VISUAL mode mappings
        -- s, x, v modes are handled the same way by which_key
        {
          mode = { 'v' },
          nowait = true,
          remap = false,
          { '<leader>oc', ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = 'AI chat buffer with selection' },
          -- { '<C-g>a', ":<C-u>'<,'>GpAppend<cr>", desc = 'Visual Append (after)' },
          -- { '<C-g>b', ":<C-u>'<,'>GpPrepend<cr>", desc = 'Visual Prepend (before)' },
          -- { '<C-g>c', ":<C-u>'<,'>GpChatNew<cr>", desc = 'Visual Chat New' },
          -- { '<C-g>g', group = 'generate into new ..' },
          -- { '<C-g>ge', ":<C-u>'<,'>GpEnew<cr>", desc = 'Visual GpEnew' },
          -- { '<C-g>gn', ":<C-u>'<,'>GpNew<cr>", desc = 'Visual GpNew' },
          -- { '<leader>oc', ":<C-u>'<,'>GpVnew<cr>", desc = 'Visual GpVnew' },
          -- { '<C-g>gp', ":<C-u>'<,'>GpPopup<cr>", desc = 'Visual Popup' },
          -- { '<C-g>gt', ":<C-u>'<,'>GpTabnew<cr>", desc = 'Visual GpTabnew' },
          -- { '<C-g>gv', ":<C-u>'<,'>GpVnew<cr>", desc = 'Visual GpVnew' },
          -- { '<C-g>i', ":<C-u>'<,'>GpImplement<cr>", desc = 'Implement selection' },
          -- { '<C-g>n', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
          -- { '<C-g>p', ":<C-u>'<,'>GpChatPaste<cr>", desc = 'Visual Chat Paste' },
          -- { '<C-g>r', ":<C-u>'<,'>GpRewrite<cr>", desc = 'Visual Rewrite' },
          -- { '<C-g>s', '<cmd>GpStop<cr>', desc = 'GpStop' },
          -- { '<C-g>t', ":<C-u>'<,'>GpChatToggle<cr>", desc = 'Visual Toggle Chat' },
          -- { '<C-g>w', group = 'Whisper' },
          -- { '<C-g>wa', ":<C-u>'<,'>GpWhisperAppend<cr>", desc = 'Whisper Append' },
          -- { '<C-g>wb', ":<C-u>'<,'>GpWhisperPrepend<cr>", desc = 'Whisper Prepend' },
          -- { '<C-g>we', ":<C-u>'<,'>GpWhisperEnew<cr>", desc = 'Whisper Enew' },
          -- { '<C-g>wn', ":<C-u>'<,'>GpWhisperNew<cr>", desc = 'Whisper New' },
          -- { '<C-g>wp', ":<C-u>'<,'>GpWhisperPopup<cr>", desc = 'Whisper Popup' },
          -- { '<C-g>wr', ":<C-u>'<,'>GpWhisperRewrite<cr>", desc = 'Whisper Rewrite' },
          -- { '<C-g>wt', ":<C-u>'<,'>GpWhisperTabnew<cr>", desc = 'Whisper Tabnew' },
          -- { '<C-g>wv', ":<C-u>'<,'>GpWhisperVnew<cr>", desc = 'Whisper Vnew' },
          -- { '<C-g>ww', ":<C-u>'<,'>GpWhisper<cr>", desc = 'Whisper' },
          -- { '<C-g>x', ":<C-u>'<,'>GpContext<cr>", desc = 'Visual GpContext' },
        },

        -- NORMAL mode mappings
        {
          mode = { 'n' },
          nowait = true,
          remap = false,
          { '<leader>oc', '<cmd>GpVnew<cr>', desc = 'AI chat prompt' },
          { '<leader>oC', '<cmd>GpChatNew vsplit<cr>', desc = 'AI chat buffer' },
          -- { '<C-g>a', '<cmd>GpAppend<cr>', desc = 'Append (after)' },
          -- { '<C-g>b', '<cmd>GpPrepend<cr>', desc = 'Prepend (before)' },
          -- { '<C-g>c', '<cmd>GpChatNew<cr>', desc = 'New Chat' },
          -- { '<C-g>f', '<cmd>GpChatFinder<cr>', desc = 'Chat Finder' },
          -- { '<C-g>g', group = 'generate into new ..' },
          -- { '<C-g>ge', '<cmd>GpEnew<cr>', desc = 'GpEnew' },
          -- { '<C-g>gn', '<cmd>GpNew<cr>', desc = 'GpNew' },
          -- { '<C-g>gp', '<cmd>GpPopup<cr>', desc = 'Popup' },
          -- { '<C-g>gt', '<cmd>GpTabnew<cr>', desc = 'GpTabnew' },
          -- { '<C-g>gv', '<cmd>GpVnew<cr>', desc = 'GpVnew' },
          -- { '<C-g>n', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
          -- { '<C-g>r', '<cmd>GpRewrite<cr>', desc = 'Inline Rewrite' },
          -- { '<C-g>s', '<cmd>GpStop<cr>', desc = 'GpStop' },
          -- { '<C-g>t', '<cmd>GpChatToggle<cr>', desc = 'Toggle Chat' },
          -- { '<C-g>w', group = 'Whisper' },
          -- { '<C-g>wa', '<cmd>GpWhisperAppend<cr>', desc = 'Whisper Append (after)' },
          -- { '<C-g>wb', '<cmd>GpWhisperPrepend<cr>', desc = 'Whisper Prepend (before)' },
          -- { '<C-g>we', '<cmd>GpWhisperEnew<cr>', desc = 'Whisper Enew' },
          -- { '<C-g>wn', '<cmd>GpWhisperNew<cr>', desc = 'Whisper New' },
          -- { '<C-g>wp', '<cmd>GpWhisperPopup<cr>', desc = 'Whisper Popup' },
          -- { '<C-g>wr', '<cmd>GpWhisperRewrite<cr>', desc = 'Whisper Inline Rewrite' },
          -- { '<C-g>wt', '<cmd>GpWhisperTabnew<cr>', desc = 'Whisper Tabnew' },
          -- { '<C-g>wv', '<cmd>GpWhisperVnew<cr>', desc = 'Whisper Vnew' },
          -- { '<C-g>ww', '<cmd>GpWhisper<cr>', desc = 'Whisper' },
          -- { '<C-g>x', '<cmd>GpContext<cr>', desc = 'Toggle GpContext' },
        },
      }
    end,
  },
}
