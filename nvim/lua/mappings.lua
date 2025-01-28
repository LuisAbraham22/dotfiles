require "nvchad.mappings"

-- add yours here

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

local map = vim.keymap.set
-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
vim.keymap.set("n", "<S-j>", "5j", { desc = "Quick move down" })
vim.keymap.set("n", "<S-k>", "5k", { desc = "Quick move up" })

--nvim spider
vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })

vim.api.nvim_create_user_command("ReplaceWord", function()
  local word = vim.fn.expand "<cword>"
  vim.fn.feedkeys(":%s/\\<" .. word .. "\\>/")
end, {})

vim.keymap.set("n", "<leader>sr", ":ReplaceWord<CR>", { noremap = true, silent = true })
vim.keymap.set("c", "<C-r><C-w>", "<C-r><C-w>", { noremap = true })
vim.keymap.set("c", "<C-r>w", "<C-r><C-w>", { noremap = true })
-- Neotest
vim.keymap.set("n", "<Leader>tr", function()
  require("neotest").run.run()
end, { desc = "Run nearest test" })
vim.keymap.set("n", "<Leader>tf", function()
  require("neotest").run.run(vim.fn.expand "%")
end, { desc = "Run all tests in file" })
vim.keymap.set("n", "<Leader>ta", function()
  require("neotest").run.run { suite = true }
end, { desc = "Run all tests in project" })
vim.keymap.set("n", "<Leader>tt", function()
  require("neotest").run.run { suite = true, extra_args = { target = true } }
end, { desc = "Run all tests in target (swift)." })
vim.keymap.set("n", "<Leader>tw", function()
  require("neotest").watch.toggle()
end, { silent = true, desc = "Watch test" })
vim.keymap.set("n", "<Leader>ts", function()
  require("neotest").summary.toggle()
end, { silent = true, desc = "Test summary" })
vim.keymap.set("n", "<Leader>to", function()
  require("neotest").output.open { short = true, enter = true }
end, { silent = true, desc = "Open test output" })
vim.keymap.set("n", "<Leader>tp", function()
  require("neotest").output_panel.toggle()
end, { silent = true, desc = "Toggle test output pane" })

-- nvim-dap
vim.keymap.set("n", "<Leader>et", function()
  require("neotest").run.run { strategy = "dap" }
end, { desc = "Debug nearest test" })
vim.keymap.set("n", "<Leader>eb", function()
  require("dap").toggle_breakpoint()
end, { desc = "Debug set breakpoint" })
vim.keymap.set("v", "<leader>ee", function()
  require("dapui").eval()
end, { desc = "Debug evaluate" })
vim.keymap.set("n", "<Leader>ec", function()
  require("dap").continue()
end, { desc = "Debug continue" })

vim.keymap.set("n", "<Leader>eo", function()
  require("dap").step_over()
end, { desc = "Debug step over" })
vim.keymap.set("n", "<Leader>ei", function()
  require("dap").step_into()
end, { desc = "Debug step into" })

vim.api.nvim_create_user_command("DAPUI", function()
  require("dapui").toggle()
end, { desc = "Open DAPUI" })
