-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = {
  "lua_ls",
  "html",
  "cssls",
  "pyright",
  "ts_ls",
  "smithy_ls",
  "jsonls",
  "gopls",
  "gradle_ls",
  "dockerls",
  "eslint",
  "sourcekit",
  "jdtls",
  "tailwindcss",
}

local on_attach_override = function(client, bufnr)
  local map = function(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end
  on_attach(client, bufnr)

  map("gd", function()
    Snacks.picker.lsp_definitions()
  end, "Goto Definition")

  map("gr", function()
    Snacks.picker.lsp_references {
      auto_close = true,
      focus = "list",
    }
  end, "References")

  map("gI", function()
    Snacks.picker.lsp_implementations()
  end, "Goto Implementation")

  map("gy", function()
    Snacks.picker.lsp_type_definitions()
  end, "Goto T[y]pe Definition")

  map("<leader>ss", function()
    Snacks.picker.lsp_symbols()
  end, "LSP Symbols")
end

-- Function to setup each LSP server
local function setup_server(server)
  -- Attempt to load a server-specific configuration file
  local status, server_config = pcall(require, "configs." .. server)

  if status and server_config then
    -- Merge common configurations with server-specific settings
    lspconfig[server].setup(vim.tbl_deep_extend("force", {
      on_attach = on_attach_override,
      on_init = on_init,
      capabilities = capabilities,
    }, server_config))
  else
    -- Setup server with default configurations if no specific config is found
    lspconfig[server].setup {
      on_attach = on_attach_override,
      on_init = on_init,
      capabilities = capabilities,
    }
  end
end

-- Iterate through the servers list and setup each one
for _, server in ipairs(servers) do
  setup_server(server)
end

-- LSP commands
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    -- NOTE: Remember that Lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    -- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    map("gh", vim.lsp.buf.hover, "[G]oto [H]over")

    -- Find references for the word under your cursor.
    -- map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    -- map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    -- map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    -- map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    -- map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.server_capabilities.inlayHintProvider then
      vim.keymap.set("n", "<S-h>", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, {
        desc = "[lsp] toggle inlay hints",
      })
    end
    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
        end,
      })
    end
  end,
})
