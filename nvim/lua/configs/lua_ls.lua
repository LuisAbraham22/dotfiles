return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = {
          "{3rd}/luv/library",
          unpack(vim.api.nvim_get_runtime_file("", true)),
        },
      },
      -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
}
