return {
	"neovim/nvim-lspconfig",
	keys = {
		{
			"<leader>rn",
			function()
				vim.lsp.buf.rename()
			end,
			"Rename",
		},
	},
	opts = {},
	config = function()
		-- Set up lspconfig.

		local servers = {
			"angularls",
			"html",
			"vtsls",
			"gopls",
			"rust_analyzer",
			"tailwindcss",
			"cssls",
			"pyright",
			"clangd",
			"zls",
			"nil_ls",
			"ruff",
			"ty",
			"sourcekit",
			"kotlin_lsp",
			"lua_ls",
		}

		vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "[F]ormat file" })

		for _, server in pairs(servers) do
			vim.lsp.enable(server)
		end
	end,
}
