local win_config = function()
	local height = math.floor(0.618 * vim.o.lines)
	local width = math.floor(0.618 * vim.o.columns)
	return {
		anchor = 'NW',
		height = height,
		width = width,
		row = math.floor(0.3 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
	}
end

return {
	{
		"echasnovski/mini.pick",
		version = "*",
		config = function()
			require "mini.pick".setup({
				window = {
					config = win_config,
				}
			})

			vim.keymap.set('n', '<C-p>', ":Pick files<CR>")
			vim.keymap.set('n', '<leader>f', ":Pick grep_live<CR>")
			vim.keymap.set('n', '<leader> ', ":Pick buffers<CR>")
		end
	},
}
