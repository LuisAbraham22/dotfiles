local bundles = {
  vim.fn.glob(vim.env.HOME .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
}

local function enable_debugger(bufnr)
  require("jdtls").setup_dap { hotcodereplace = "auto" }
  require("jdtls.dap").setup_dap_main_class_configs()
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "<leader>tc", "<cmd>lua require('jdtls').test_class()<cr>", opts)
  vim.keymap.set("n", "<leader>tm", "<cmd>lua require('jdtls').test_nearest_method()<cr>", opts)
  vim.keymap.set("n", "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", opts)
  vim.keymap.set("n", "<leader>dt", "<cmd>lua require('dap').terminate()<cr>", opts)
end

-- Needed for running/debugging unit tests
vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(vim.env.HOME .. "/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n")
)

local ws_folders_lsp = {}
return {
  filetypes = { "java" },
  on_attach = function(_, bufnr)
    enable_debugger(bufnr)
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
    local bemol_dir = vim.fs.find({ ".bemol" }, { upward = true, type = "directory" })[1]
    if bemol_dir then
      local file = io.open(bemol_dir .. "/ws_root_folders", "r")
      if file then
        for line in file:lines() do
          table.insert(ws_folders_lsp, line)
        end
        file:close()
      end
    end
    for _, line in ipairs(ws_folders_lsp) do
      vim.lsp.buf.add_workspace_folder(line)
    end
  end,
  cmd = {
    "jdtls",
    "-configuration",
    "/Users/luiabrah/.cache/jdtls/config",
    "-data",
    "/Users/luiabrah/.cache/jdtls/workspace",
    "--jvm-arg=-javaagent:" .. require("mason-registry").get_package("jdtls"):get_install_path() .. "/lombok.jar",
  },
  settings = {
    java = {
      home = "/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home",
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      signatureHelp = { enabled = true },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      inlayHints = {
        parameterNames = {
          enabled = "all", -- literals, all, none
        },
        typeParameters = {
          enabled = true,
        },
      },
    },
  },
  init_options = {
    workspaceFolders = ws_folders_lsp,
    bundles = bundles,
  },
}
