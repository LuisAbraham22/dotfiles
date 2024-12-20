return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
          require "configs.lspconfig"
          require('mason').setup()
          require('mason-lspconfig').setup({
            -- Install these LSPs automatically
            ensure_installed = {
                "jdtls", 
                "pyright",
                "ts_ls",
                "smithy_ls",
                "jsonls",
                "gopls",
                "gradle_ls",
                "dockerls",
            },
            automatic_installation = true
          })
      
          require('mason-tool-installer').setup({
            -- Install these linters, formatters, debuggers automatically
            ensure_installed = {
            "stylua",
            "html-lsp",
            "css-lsp", 
              'java-debug-adapter',
              'java-test',
            },
            auto_update = true,
            run_on_start = true
          })
          vim.api.nvim_command('MasonToolsInstall')
          vim.api.nvim_create_autocmd("User", {
            pattern = "MasonToolsStartingInstall",
            command = "Mason",
          })
        end,
        dependencies = {
            {
                "williamboman/mason.nvim",
             },
                 -- https://github.com/williamboman/mason-lspconfig.nvim
            { 'williamboman/mason-lspconfig.nvim' },

            -- Auto-Install LSPs, linters, formatters, debuggers
            -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
            { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

            -- Useful status updates for LSP
            -- https://github.com/j-hui/fidget.nvim
            { 'j-hui/fidget.nvim', opts = {} },
        }
      },

      {
        "mfussenegger/nvim-jdtls",
        dependencies = {
          "mfussenegger/nvim-dap"
        }
      },
      {
        "mfussenegger/nvim-dap",
        config = function ()
        end
      },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
      }
}