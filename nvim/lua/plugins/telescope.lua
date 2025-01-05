return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    config = function()
      require("telescope").load_extension "fzf"
      require("telescope").setup {
        pickers = {
          find_files = {
            theme = "ivy",
          },
        },
      }
    end,
  },
  opts = {
    defaults = {
      file_ignore_patterns = {
        "node_modules",
        "%.class",
      },
      path_display = {
        shorten = {
          len = 3,
          exclude = { 1, -1 },
        },
        truncate = true,
      },
      dynamic_preview_title = true,
    },
    extensions_list = { "fzf" },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  },
}
