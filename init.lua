-- netrw disabled for mini.files
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Show which line your cursor is on
vim.opt.cursorline = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Set default shell
if vim.loop.os_uname().sysname == "Windows_NT" then
	vim.opt.shell = "pwsh"
else
	vim.opt.shell = "fish"
end

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "]b", "<CMD>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<CMD>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Theme

require("gruvbox").setup({
	transparent_mode = false,
})

vim.opt.background = "dark"
vim.cmd.colorscheme("gruvbox")

-- transparency
vim.cmd([[
	highlight Normal guibg=none
	highlight NonText guibg=none
	highlight Normal ctermbg=none
	highlight NonText ctermbg=none
]])

-- Tabline customization
vim.api.nvim_set_hl(0, "TabLine", {
	bg = "NONE",     -- Transparent background
	underline = true, -- Enable underline for bottom border
	sp = "#4e4e4e",  -- Color for the underline (grayish, adjust to match tokyonight)
})

vim.api.nvim_set_hl(0, "TabLineSel", {
	bg = "NONE",     -- Transparent background
	bold = true,     -- Make selected tab bold
	underline = true, -- Consistent bottom border
	sp = "#4e4e4e",  -- Same underline color
	fg = "#7aa2f7",  -- Optional: Use a brighter color for selected tab (tokyonight blue)
})

vim.api.nvim_set_hl(0, "TabLineFill", {
	bg = "NONE",     -- Transparent background
	underline = true, -- Bottom border for empty tabline space
	sp = "#4e4e4e",  -- Same underline color
})
-- Theme

-- tabs
vim.keymap.set({ "n", "t" }, "<c-k>", "<CMD>tabnext +1<CR>", { desc = "Next tab" })
vim.keymap.set({ "n", "t" }, "<c-j>", "<CMD>tabnext -1<CR>", { desc = "Previous tab" })
vim.keymap.set({ "n" }, "<leader>nt", "<CMD>tabnew<CR>", { desc = "New tab" })
vim.keymap.set({ "n" }, "<leader>ntt", function()
	vim.api.nvim_command("tabnew")

	vim.api.nvim_command("terminal")
	vim.api.nvim_command("startinsert")

	terminal_window = vim.api.nvim_get_current_win()
end, { desc = "New terminal tab" })

-- LSP
vim.keymap.set('n', '<leader>F', vim.lsp.buf.format)

vim.lsp.enable('nil_ls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('ty')
vim.lsp.enable('ruff')
vim.lsp.enable('vtsls')
vim.lsp.enable('tailwindcss')
vim.lsp.enable('cssls')
vim.lsp.enable('oxlint')
vim.lsp.enable('html')
vim.lsp.enable('jsonls')
-- LSP

-- Mini Files
require("mini.files").setup({
	windows = {
		preview = true,
		width_focus = 30,
		width_nofocus = 15,
		width_preview = 40,
	},
	options = {
		use_as_default_explorer = true,
	},
})

vim.keymap.set("n", "<leader>e", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = "Open file explorer" })
-- Mini Files

-- Mini Pick
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

require "mini.pick".setup({
	window = {
		config = win_config,
	}
})

vim.keymap.set('n', '<C-p>', ":Pick files<CR>")
vim.keymap.set('n', '<leader>f', ":Pick grep_live<CR>")
vim.keymap.set('n', '<leader> ', ":Pick buffers<CR>")
-- Mini Pick

-- AutoComplete
-- 1. Global UI & Behavior Settings
vim.opt.completeopt = { "menu", "menuone", "noinsert" }
vim.opt.pumheight = 10 -- LIMIT HEIGHT: Only show 10 items (still scrollable)
vim.opt.shortmess:append("c")

-- 2. Smart Filtering Omnifunc
-- This wraps the standard LSP omnifunc to filter out noise
_G.filtered_omnifunc = function(findstart, base)
	local res = vim.lsp.omnifunc(findstart, base)
	if findstart == 0 and type(res) == 'table' and res.items then
		local filtered = {}
		for _, item in ipairs(res.items) do
			-- Filter out 'Text' (1) and 'Snippet' (15)
			-- You can add more IDs to exclude here
			local kind = item.user_data and item.user_data.nvim and item.user_data.nvim.lsp and
					item.user_data.nvim.lsp.completion_item.kind
			if kind ~= 1 and kind ~= 15 then
				table.insert(filtered, item)
			end
		end
		res.items = filtered
	end
	return res
end

-- 3. Apply to LSP buffers
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		vim.bo[args.buf].omnifunc = 'v:lua.filtered_omnifunc'
	end,
})

-- 4. Auto-trigger Menu (only when omnifunc is set)
vim.api.nvim_create_autocmd("InsertCharPre", {
	callback = function()
		if vim.fn.pumvisible() == 0 and vim.bo.omnifunc ~= "" then
			local char = vim.v.char
			if char:match("[%w%.]") then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true), "n", false)
			end
		end
	end,
})

-- 5. Keymaps (Enter & Tab)
vim.keymap.set('i', '<CR>', function()
	if vim.fn.pumvisible() ~= 0 then
		if vim.fn.complete_info()["selected"] == -1 then
			return vim.api.nvim_replace_termcodes("<C-n><C-y>", true, true, true)
		else
			return vim.api.nvim_replace_termcodes("<C-y>", true, true, true)
		end
	else
		return vim.api.nvim_replace_termcodes("<CR>", true, true, true)
	end
end, { expr = true })

vim.keymap.set('i', '<Tab>', function()
	return vim.fn.pumvisible() ~= 0 and "<C-n>" or "<Tab>"
end, { expr = true })

vim.keymap.set('i', '<S-Tab>', function()
	return vim.fn.pumvisible() ~= 0 and "<C-p>" or "<S-Tab>"
end, { expr = true })
-- AutoComplete

-- Autoclose
local function autoclose_pair(open, close)
	local col = vim.fn.col('.')
	local line = vim.fn.getline('.')
	local char_after = line:sub(col, col)

	-- Only close if:
	-- 1. At the end of a line (char_after is "")
	-- 2. Followed by a space
	-- 3. Followed by a closing bracket/brace
	if char_after == "" or char_after:match("%s") or char_after:match("[%)%]}]") then
		local keys = vim.api.nvim_replace_termcodes(open .. close .. "<Left>", true, false, true)
		vim.api.nvim_feedkeys(keys, "n", true)
		return ""
	else
		return open
	end
end

-- Map the pairs
local pair_map = {
	['('] = ')',
	['['] = ']',
	['{'] = '}',
	["'"] = "'",
	['"'] = '"',
}

for open, close in pairs(pair_map) do
	vim.keymap.set('i', open, function()
		return autoclose_pair(open, close)
	end, { expr = true, noremap = true })
end
-- Autoclose
