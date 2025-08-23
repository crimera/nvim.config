return {
	{ 
		"echasnovski/mini.pick", 
		version = "*",
		config = function()
			require "mini.pick".setup()

			vim.keymap.set('n', '<C-p>', ":Pick files<CR>")
			vim.keymap.set('n', '<leader>f', ":Pick grep_live<CR>")
		end 
	},
}
