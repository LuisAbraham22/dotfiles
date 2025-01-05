return {
  "windwp/nvim-ts-autotag",
  ft = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "html",
  },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
