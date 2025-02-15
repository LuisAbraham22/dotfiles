-- Debugging Support
return {
  -- https://github.com/rcarriga/nvim-dap-ui
  "rcarriga/nvim-dap-ui",
  event = "VeryLazy",
  dependencies = {
    -- https://github.com/mfussenegger/nvim-dap
    "mfussenegger/nvim-dap",
    -- https://github.com/nvim-neotest/nvim-nio
    "nvim-neotest/nvim-nio",
    -- https://github.com/theHamsta/nvim-dap-virtual-text
    "theHamsta/nvim-dap-virtual-text", -- inline variable text while debugging
    -- https://github.com/nvim-telescope/telescope-dap.nvim
    "nvim-telescope/telescope-dap.nvim", -- telescope integration with dap
  },
  opts = {
    controls = {
      element = "repl",
      enabled = false,
      icons = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = "",
      },
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
      border = "single",
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    force_buffers = true,
    icons = {
      collapsed = "",
      current_frame = "",
      expanded = "",
    },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t",
    },
    render = {
      indent = 1,
      max_value_lines = 100,
    },
  },
  config = function(_, opts)
    local dap = require "dap"
    local dapui = require "dapui"
    dapui.setup(opts)
    vim.keymap.set("n", "<leader>xq", function()
      dap.close()
      dapui.close()
    end, { desc = "Close Session" })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      require("dapui").open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      -- Commented to prevent DAP UI from closing when unit tests finish
      -- require('dapui').close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      -- Commented to prevent DAP UI from closing when unit tests finish
      -- require('dapui').close()
    end

    -- Add dap configurations based on your language/adapter settings
    -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    dap.configurations.java = {
      {
        name = "Debug Launch (2GB)",
        type = "java",
        request = "launch",
        vmArgs = "" .. "-Xmx2g ",
      },
      {
        name = "Debug Attach (8000)",
        type = "java",
        request = "attach",
        hostName = "127.0.0.1",
        port = 8000,
      },
      {
        name = "Debug Attach (5005)",
        type = "java",
        request = "attach",
        hostName = "127.0.0.1",
        port = 5005,
      },
      {
        name = "My Custom Java Run Configuration",
        type = "java",
        request = "launch",
        -- You need to extend the classPath to list your dependencies.
        -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
        -- classPaths = {},

        -- If using multi-module projects, remove otherwise.
        -- projectName = "yourProjectName",

        -- If using the JDK9+ module system, this needs to be extended
        -- `nvim-jdtls` would automatically populate this property
        -- modulePaths = {},
        vmArgs = "" .. "-Xmx2g ",
      },
    }
  end,
}
