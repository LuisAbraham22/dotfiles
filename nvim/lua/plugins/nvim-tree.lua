local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

return {
  {
    "nvim-tree/nvim-web-devicons",
  },
  {
    "nvim-tree/nvim-tree.lua",
    after = "nvim-web-devicons",
    requires = "nvim-tree/nvim-web-devicons",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      disable_netrw = true,
      view = {
        adaptive_size = true,
        -- float = {
        --     enable = true,
        -- },
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      git = {
        ignore = false,
      },
    },
    --     renderer = {
    --         root_folder_label = false,
    --         highlight_git = true,
    --         highlight_opened_files = "none",

    --         indent_markers = {
    --           enable = false,
    --         },

    --         icons = {
    --           show = {
    --             file = true,
    --             folder = true,
    --             folder_arrow = true,
    --             -- git = true,
    --           },

    --           glyphs = {
    --             default = "󰈚",
    --             symlink = "",
    --             folder = {
    --               default = "",
    --               empty = "",
    --               empty_open = "",
    --               open = "",
    --               symlink = "",
    --               symlink_open = "",
    --               arrow_open = "",
    --               arrow_closed = "",
    --             },
    --             git = {
    --               unstaged = "✗",
    --               staged = "✓",
    --               unmerged = "",
    --               renamed = "➜",
    --               untracked = "★",
    --               deleted = "",
    --               ignored = "◌",
    --             },
    --           },
    --         },
    --       },
    -- }
  },
}
