return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
		-- Set filetype for *.swiftinterface
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, 
		{
			pattern = "*.swiftinterface",
			callback = function()
				vim.bo.filetype = "swift"
			end,
		})
      require'nvim-treesitter.configs'.setup {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"java",
			"python",
			"go",
			"tsx",
			"typescript",
			"javascript",
			"smithy",
			"rust",
			"tsx",
			"swift",
		  },
		auto_install = false,
		highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
			return true
			end
		end,
		additional_vim_regex_highlighting = false,
		},
      }
    end,
  }
}
