-- SourceKit-LSP increasingly relies on the editor informing the server when certain files change.
-- This need is communicated through dynamic registration. You don’t have to understand what that
-- means, but Neovim doesn’t implement dynamic registration. You’ll notice this when you update
-- your package manifest, or add new files to your compile_commands.json file and LSP doesn’t
-- work without restarting Neovim.
--
-- Instead, we know that SourceKit-LSP needs this functionality, so we’ll enable it statically.
-- We’ll update our sourcekit setup configuration to manually set the didChangeWatchedFiles
-- capability.
local util = require "lspconfig/util"
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
  -- Optionally call the default on_attach to retain default behaviors
  -- nvlsp.on_attach(client, bufnr)

  -- Create buffer-local autocommands for inlay hints
  vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    buffer = bufnr,
    callback = function(args)
      if args.event == "InsertEnter" then
        vim.lsp.inlay_hint.enable(true)
      else -- InsertLeave
        vim.lsp.inlay_hint.enable(false)
      end
    end,
  })
end

-- Return the server-specific configuration
return {
  cmd = { "sourcekit-lsp" }, -- Adjust the command if necessary
  filetypes = { "swift", "objective-c", "objective-cpp" }, -- Add relevant filetypes
  root_dir = util.root_pattern("Package.swift", ".git"), -- Adjust root patterns as needed
  on_attach = sourcekit_on_attach,
  capabilities = capabilities,
  -- Add any additional settings if required
}
