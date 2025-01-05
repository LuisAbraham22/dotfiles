return {
  "saecki/crates.nvim",
  tag = "stable",
  ft = { "rust", "toml" },
  config = function()
    require("crates").setup {
      completion = {
        cmp = {
          enabled = true,
        },
      },
    }
    require("cmp").setup.buffer {
      sources = { { name = "crates" } },
    }
  end,
}