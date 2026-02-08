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

vim.opt.cmdheight = 0

require("gruvbox").setup({
	transparent_mode = true,
})
vim.opt.background = "dark"
vim.cmd.colorscheme("gruvbox")

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

-- Git status highlight groups for mini.files
vim.api.nvim_set_hl(0, "MiniFilesGitModified", { fg = "#fabd2f", bold = true })  -- Yellow
vim.api.nvim_set_hl(0, "MiniFilesGitUntracked", { fg = "#b8bb26", bold = true })  -- Green
vim.api.nvim_set_hl(0, "MiniFilesGitDeleted", { fg = "#fb4934", bold = true })     -- Red
vim.api.nvim_set_hl(0, "MiniFilesGitAdded", { fg = "#8ec07c", bold = true })       -- Light green
vim.api.nvim_set_hl(0, "MiniFilesGitRenamed", { fg = "#d3869b", bold = true })    -- Purple

-- Gitsigns highlight groups for line/number highlighting
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#b8bb26", bg = "#1a1a1a" })           -- Green
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#fabd2f", bg = "#1a1a1a" })       -- Yellow
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#fb4934", bg = "#1a1a1a" })         -- Red
vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = "#1a2a1a" })                          -- Dark green bg
vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = "#2a2a1a" })                       -- Dark yellow bg
vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { bg = "#2a1a1a" })                        -- Dark red bg
vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = "#b8bb26", bold = true })             -- Green line number
vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = "#fabd2f", bold = true })          -- Yellow line number
vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = "#fb4934", bold = true })          -- Red line number
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

vim.lsp.enable('nixd')
vim.lsp.enable('lua_ls')
vim.lsp.enable('ty')
vim.lsp.enable('ruff')
vim.lsp.enable('vtsls')
vim.lsp.enable('tailwindcss')
vim.lsp.enable('cssls')
vim.lsp.enable('oxlint')
vim.lsp.enable('html')
vim.lsp.enable('jsonls')
vim.lsp.enable('zls')
vim.lsp.enable('rust_analyzer')
-- LSP

-- Mini Git (provides git status data)
require("mini.git").setup({})

-- Gitsigns (line-level git signs with highlighting)
require("gitsigns").setup({
	signs = {
		add = { text = '+' },
		change = { text = '~' },
		delete = { text = '-' },
		topdelete = { text = '‾' },
		changedelete = { text = '~' },
	},
	-- Enable line number highlighting
	numhl = true,
	-- Enable line highlighting (colors the entire line background)
	linehl = true,
	-- Enable word diff in virtual text (inline word-level highlighting)
	word_diff = true,
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		
		-- Navigation
		vim.keymap.set('n', ']h', function()
			if vim.wo.diff then return ']h' end
			vim.schedule(function() gs.next_hunk() end)
			return '<Ignore>'
		end, { expr = true, buffer = bufnr, desc = "Next hunk" })
		
		vim.keymap.set('n', '[h', function()
			if vim.wo.diff then return '[h' end
			vim.schedule(function() gs.prev_hunk() end)
			return '<Ignore>'
		end, { expr = true, buffer = bufnr, desc = "Previous hunk" })
		
		-- Actions
		vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
		vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
		vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { buffer = bufnr, desc = "Stage hunk" })
		vim.keymap.set('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { buffer = bufnr, desc = "Reset hunk" })
		vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
		vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
		vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })
		vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
		vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end, { buffer = bufnr, desc = "Blame line" })
		vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle line blame" })
		vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = bufnr, desc = "Diff this" })
		vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end, { buffer = bufnr, desc = "Diff this ~" })
		vim.keymap.set('n', '<leader>td', gs.toggle_deleted, { buffer = bufnr, desc = "Toggle deleted" })
	end,
})

-- Mini Files with Git Status Indicators
-- Git status cache per directory to avoid blocking UI
local git_status_cache = {}

-- Helper: Get git status for all files in a directory
local function update_git_status_cache(dir_path)
	local status_map = {}
	local handle = io.popen('git -C "' .. dir_path .. '" status --porcelain 2>/dev/null')
	if handle then
		for line in handle:lines() do
			-- Parse porcelain format: XY filename
			-- X = index status, Y = working tree status
			local status = line:sub(1, 2)
			local filename = line:sub(4)
			status_map[dir_path .. "/" .. filename] = {
				index = status:sub(1, 1),
				worktree = status:sub(2, 2)
			}
		end
		handle:close()
	end
	git_status_cache[dir_path] = status_map
end

-- Get status for a specific file (uses cache)
local function get_file_git_status(file_path)
	local dir = vim.fn.fnamemodify(file_path, ":h")
	
	-- Update cache if needed
	if not git_status_cache[dir] then
		update_git_status_cache(dir)
	end
	
	local cache = git_status_cache[dir] or {}
	local file_status = cache[file_path]
	
	if not file_status then return nil end
	
	-- Determine overall status (prioritize worktree over index)
	local wt = file_status.worktree
	local idx = file_status.index
	
	if wt == "M" or idx == "M" then return "modified" end
	if wt == "?" or idx == "?" then return "untracked" end
	if wt == "D" or idx == "D" then return "deleted" end
	if wt == "A" or idx == "A" then return "added" end
	if wt == "R" or idx == "R" then return "renamed" end
	
	return nil
end

-- Custom prefix: Git status icon + file icon
local git_prefix = function(fs_entry)
	local icon, hl = MiniFiles.default_prefix(fs_entry)
	local status = get_file_git_status(fs_entry.path)
	
	-- Git status indicators
	local git_icons = {
		modified = "✗ ",
		untracked = "+ ",
		deleted = "- ",
		added = "✓ ",
		renamed = "→ ",
	}
	
	local git_hls = {
		modified = "MiniFilesGitModified",
		untracked = "MiniFilesGitUntracked",
		deleted = "MiniFilesGitDeleted",
		added = "MiniFilesGitAdded",
		renamed = "MiniFilesGitRenamed",
	}
	
	if status then
		return git_icons[status] .. icon, git_hls[status]
	end
	
	return icon, hl
end

-- Custom highlight: Color filename based on git status
local git_highlight = function(fs_entry)
	local base_hl = MiniFiles.default_highlight(fs_entry)
	local status = get_file_git_status(fs_entry.path)
	
	if status then
		return "MiniFilesGit" .. status:gsub("^%l", string.upper)
	end
	
	return base_hl
end

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
	content = {
		prefix = git_prefix,      -- Add git status icons
		highlight = git_highlight, -- Color files by git status
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

-- Completion (blink.cmp)
require("blink.cmp").setup({
	keymap = {
		preset = "enter",  -- Enter to accept completion
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
	},

	appearance = {
		nerd_font_variant = "mono",
	},

	completion = {
		documentation = { auto_show = true },
		menu = {
			max_height = 10,  -- Limit popup height to 10 items
		},
		accept = {
			auto_brackets = { enabled = true },  -- Smart bracket insertion
		},
		list = {
			selection = {
				preselect = true,       -- Auto-select first item
				auto_insert = false,    -- Don't auto-insert until Enter is pressed
			},
		},
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		-- Filter out unwanted completion kinds (Text and Snippet)
		providers = {
			lsp = {
				transform_items = function(_, items)
					-- Filter out Text (1) and Snippet (15) completion kinds
					return vim.tbl_filter(function(item)
						local kind = item.kind
						return kind ~= 1 and kind ~= 15
					end, items)
				end,
			},
		},
	},

	signature = { enabled = false },

	fuzzy = {
		implementation = "prefer_rust_with_warning",  -- Fast Rust-based fuzzy matching
	},
})
-- Completion

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
