return {
  'scalameta/nvim-metals',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',
  },
  ft = { 'scala', 'sbt' },
  opts = function()
    local metals_config = require('metals').bare_config()
    metals_config.on_attach = function(client, bufnr)
      require('metals').setup_dap()
    end
    metals_config.settings = {
      showImplicitArguments = true,
      showInferredType = true,
      excludedPackages = { 'akka.actor.typed.javadsl', 'akka.actor.typed.scaladsl' },
      startMcpServer = true,
    }

    -- It's highly recommended to either set your `statusBarProvider` to `"on"`
    -- or `"off"`. By default it's set to `"show-message"` to ensure that anyone
    -- starting out will see the messages, but this will not give you the best user
    -- experience.
    --
    -- If you set it to `"off"`, you're telling Metals to use the default LSP
    -- progress mechanism. If you do this, you'll need to ensure you have a plugin
    -- installed that handles progress like https://github.com/j-hui/fidget.nvim, for
    -- example. This is the recommended way.
    metals_config.init_options.statusBarProvider = 'off'

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = self.ft,
      callback = function()
        require('metals').initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
