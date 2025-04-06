return {
  "folke/noice.nvim",
  event = "VeryLazy",

  opts = {
    lsp = {
      signature = {
        enabled = false,
      },
    },
    presets = {
      long_message_to_split = true, -- long messages will be sent to a split
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
  },
}
