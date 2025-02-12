local function translate_fn(lang)
  return function(gp, params)
    local template = 'You are a Translator. Please translate the following text to'
      .. lang
      .. ':\n\n'
      .. '```{{selection}}\n```\n\n'
      .. '\n\nRespond exclusively with the snippet that should replace the selection above.'

    local agent = gp.get_command_agent()

    gp.Prompt(
      params,
      gp.Target.rewrite,
      agent,
      template,
      nil, -- command will run directly without any prompting for user input
      nil -- no predefined instructions (e.g. speech-to-text from Whisper)
    )
  end
end

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
          copilot = {
            disable = false,
            secret = {
              'bash',
              '-c',
              "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
            },
          },
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
        hooks = {
          TranslateFi = translate_fn 'Finnish',
          TranslateSv = translate_fn 'Swedish',
        },
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
          { '<leader>ocC', ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = 'New chat with selection' },
          { '<leader>occ', ":<C-u>'<,'>GpChatToggle vsplit<cr>", desc = 'Toggle chat with selection' },
          { '<leader>oci', ":<C-u>'<,'>GpImplement<cr>", desc = 'Implement selection' },
        },

        -- NORMAL mode mappings
        {
          mode = { 'n' },
          nowait = true,
          remap = false,
          { '<leader>ocC', '<cmd>GpChatNew vsplit<cr>', desc = 'New chat' },
          { '<leader>occ', '<cmd>GpChatToggle vsplit<cr>', desc = 'Toggle last used chat' },
          { '<leader>ocn', '<cmd>GpNextAgent<cr>', desc = 'Next agent' },
          { '<leader>ocp', '<cmd>GpPopup<cr>', desc = 'Popup' },
        },
      }
    end,
  },
}
