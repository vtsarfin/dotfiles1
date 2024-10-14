vim.g.bigfile_size=1024*1024
return {
	{
		"folke/tokyonight.nvim",
			lazy = true,
			opts = { style = "moon" },
	},
		{
			"LazyVim/LazyVim",
			opts = {
				colorscheme = "tokyonight",
			}
		}
}



