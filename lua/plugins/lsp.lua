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
			"ruff"
		}

		for _, server in pairs(servers) do
			if type(server) == "table" then
				require("lspconfig")[server[1]].setup(vim.tbl_extend("force", {
					capabilities = capabilities,
				}, server.opts))
			else
				require("lspconfig")[server].setup({
					capabilities = capabilities,
				})
			end
		end
	end,
}
