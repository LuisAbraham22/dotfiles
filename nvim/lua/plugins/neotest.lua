return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "mmllr/neotest-swift-testing",
      "rcasia/neotest-java",
    },
    config = function()
      local neotest = require "neotest"
      neotest.setup {
        adapters = {
          require "neotest-swift-testing",
          require "neotest-java",
        },
        output = {
          open_on_run = true,
        },
      }

      vim.keymap.set("n", "<Leader>tr", function()
        neotest.output_panel.clear()
        neotest.run.run()
        neotest.output_panel.open()
      end, { desc = "Run nearest test" })
      vim.keymap.set("n", "<Leader>tt", function()
        neotest.output_panel.clear()
        neotest.run.run_last()
        neotest.output_panel.open()
      end, { desc = "Run last test" })
      vim.keymap.set("n", "<Leader>tf", function()
        neotest.output_panel.clear()
        neotest.run.run(vim.fn.expand "%")
        neotest.output_panel.open()
      end, { desc = "Run all tests in file" })
    end,
  },
  {
    "mmllr/neotest-swift-testing",
  },
  {
    "rcasia/neotest-java",
  },
}
