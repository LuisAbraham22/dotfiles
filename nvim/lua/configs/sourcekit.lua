
-- SourceKit-LSP increasingly relies on the editor informing the server when certain files change.
-- This need is communicated through dynamic registration. You don’t have to understand what that
-- means, but Neovim doesn’t implement dynamic registration. You’ll notice this when you update
-- your package manifest, or add new files to your compile_commands.json file and LSP doesn’t
-- work without restarting Neovim.
--
local nvlsp = require "nvchad.configs.lspconfig"

-- Clone the default capabilities to avoid modifying them globally
local capabilities = vim.deepcopy(nvlsp.capabilities)

-- Merge the specific workspace capability
capabilities.workspace = vim.tbl_deep_extend("force", capabilities.workspace or {}, {
  didChangeWatchedFiles = {
    dynamicRegistration = true,
  },
})

-- Define a custom on_attach function for sourcekit
local function sourcekit_on_attach(client, bufnr)
  nvlsp.on_attach(client, bufnr)

  local inlay_hint = vim.lsp.inlay_hint

  -- Create buffer-local autocommands for inlay hints
  vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    buffer = bufnr,
    callback = function(args)
      if not inlay_hint or not client.server_capabilities.inlayHintProvider then
        return
      end

      local enable = args.event == "InsertEnter"
      if inlay_hint.enable then
        local ok = pcall(inlay_hint.enable, enable, { bufnr = bufnr })
        if not ok then
          pcall(inlay_hint.enable, bufnr, enable)
        end
      end
    end,
  })
end

-- Return the server-specific configuration
return {
  on_attach = sourcekit_on_attach,
  capabilities = capabilities,
}
