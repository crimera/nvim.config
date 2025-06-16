return {
	"folke/tokyonight.nvim",
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("tokyonight-night")

		-- Tabline customization
		vim.api.nvim_set_hl(0, "TabLine", {
			bg = "NONE", -- Transparent background
			underline = true, -- Enable underline for bottom border
			sp = "#4e4e4e", -- Color for the underline (grayish, adjust to match tokyonight)
		})

		vim.api.nvim_set_hl(0, "TabLineSel", {
			bg = "NONE", -- Transparent background
			bold = true, -- Make selected tab bold
			underline = true, -- Consistent bottom border
			sp = "#4e4e4e", -- Same underline color
			fg = "#7aa2f7", -- Optional: Use a brighter color for selected tab (tokyonight blue)
		})

		vim.api.nvim_set_hl(0, "TabLineFill", {
			bg = "NONE", -- Transparent background
			underline = true, -- Bottom border for empty tabline space
			sp = "#4e4e4e", -- Same underline color
		})
	end,
	opts = {
		transparent = true,
		styles = {
			sidebars = "transparent", -- Make sidebars transparent
			floats = "transparent", -- Make floating windows transparent
		},
	},
}
