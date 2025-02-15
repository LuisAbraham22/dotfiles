return {
  { "zapling/mason-conform.nvim" },
  { -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    depedencies = {},
    log_level = vim.log.levels.DEBUG,
    keys = {
      {
        "<leader>FB",
        function()
          require("conform").format { async = true, lsp_format = "fallback" }
        end,
        mode = "",
        desc = "[F]ormat [B]uffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = "never"
        else
          lsp_format_opt = "fallback"
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { "prettierd", stop_after_first = true },
        go = { "goimports", "gofmt" },
        -- You can also customize some of the format options for the filetype
        rust = { "rustfmt", lsp_format = "fallback" },
        html = { { "prettierd" } },
        javascriptreact = { "prettierd" },
        markdown = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        java = {
          "google-java-format",
        },
        swift = {
          "swift_format",
        },
      },
      formatters = {
        ["google-java-format"] = {
          prepend_args = { "--aosp" },
        },
      },
    },
  },
}
