-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}
M.ui = {
  telescope = { style = "bordered" }, -- borderless / bordered
  statusline = {
    theme = "default",
    separator_style = "arrow",
  },
  lsp = {
    signature = {
      focusable = false,
      border = "rounded",
    },
  },
  cmp = {
    format_colors = {
      tailwind = true,
    },
  },
}

M.base46 = {
  theme = "gruvchad",

  hl_override = {
    Normal = { bg = "#181818" },
  },
}

M.colorify = {
  enabled = true,
  mode = "virtual", -- fg, bg, virtual
  virt_text = "󱓻 ",
  highlight = { hex = true, lspvars = true },
}

return M
