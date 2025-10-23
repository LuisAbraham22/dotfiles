return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "bash",
          "c",
          "diff",
          "html",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "query",
          "vim",
          "vimdoc",
          "java",
          "python",
          "go",
          "tsx",
          "typescript",
          "javascript",
          "smithy",
          "rust",
          "tsx",
          "swift",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
          --  If you are experiencing weird indenting issues, add the language to
          --  the list of additional_vim_regex_highlighting and disabled languages for indent.
          additional_vim_regex_highlighting = { "ruby" },
        },
        indent = { enable = false, disable = { "ruby" } },
      }

      -- Set filetype for *.swiftinterface
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { -- Corrected event format
        pattern = "*.swiftinterface",
        callback = function()
          vim.bo.filetype = "swift"
        end,
      })
    end,
  },
}
