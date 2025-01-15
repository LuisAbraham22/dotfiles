require "nvchad.mappings"

-- add yours here

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
local builtin = require "telescope.builtin"
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>en", function()
  builtin.find_files {
    cwd = vim.fn.stdpath "config",
  }
end, { desc = "Telescope edit neovim config" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "[G]it [S]tatus" })
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
