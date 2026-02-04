# Neovim Configuration

A Nix-based Neovim setup with AMOLED black theme, LSP support, git integration, and file management.

---

## Overview

This configuration provides a minimal yet powerful Neovim setup with:
- AMOLED black background theme (Gruvbox)
- Git integration with line/word highlighting
- File explorer with git status indicators
- LSP support for multiple languages
- Fuzzy finder and buffer management
- Auto-completion and auto-pairing

---

## Keymaps

> **Leader key:** `Space`

### General Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<Esc>` | Normal | Clear search highlighting |
| `<C-h>` | Normal | Move focus to left window |
| `<C-l>` | Normal | Move focus to right window |
| `<C-j>` | Normal | Move focus to lower window |
| `<C-k>` | Normal | Move focus to upper window |

### Buffer Management

| Key | Mode | Description |
|-----|------|-------------|
| `]b` | Normal | Next buffer |
| `[b` | Normal | Previous buffer |

### Tab Management

| Key | Mode | Description |
|-----|------|-------------|
| `<C-k>` | Normal/Terminal | Next tab |
| `<C-j>` | Normal/Terminal | Previous tab |
| `<leader>nt` | Normal | New tab |
| `<leader>ntt` | Normal | New tab with terminal |

### Diagnostics (LSP)

| Key | Mode | Description |
|-----|------|-------------|
| `[d` | Normal | Go to previous diagnostic message |
| `]d` | Normal | Go to next diagnostic message |
| `<leader>d` | Normal | Show diagnostic error messages (floating) |
| `<leader>q` | Normal | Open diagnostic quickfix list |
| `<leader>F` | Normal | Format buffer |

---

## Git (Gitsigns)

### Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `]h` | Normal | Next git hunk |
| `[h` | Normal | Previous git hunk |

### Hunk Actions

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>hs` | Normal/Visual | Stage hunk |
| `<leader>hr` | Normal/Visual | Reset hunk |
| `<leader>hS` | Normal | Stage entire buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hR` | Normal | Reset entire buffer |
| `<leader>hp` | Normal | Preview hunk changes |

### Git Information

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>hb` | Normal | Blame line (full) |
| `<leader>hd` | Normal | Diff this file |
| `<leader>hD` | Normal | Diff this file against HEAD~ |

### Toggles

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>tb` | Normal | Toggle line blame |
| `<leader>td` | Normal | Toggle deleted lines |

### Visual Features

Gitsigns provides three levels of git highlighting:
- **Sign column** (`+`, `~`, `-`) - Signs in the gutter
- **Line numbers** - Colored line numbers (green/yellow/red)
- **Line background** - Colored background for changed lines
- **Word diff** - Inline word-level highlighting showing exact word changes

---

## File Explorer (Mini Files)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>e` | Normal | Open file explorer at current file |

### Navigation (inside Mini Files)

| Key | Mode | Description |
|-----|------|-------------|
| `h` | Normal | Go to parent directory |
| `l` | Normal | Go into directory / open file |
| `j/k` | Normal | Move up/down |
| `q` | Normal | Close explorer |
| `<BS>` | Normal | Reset explorer |
| `m<char>` | Normal | Set bookmark |
| `'<char>` | Normal | Jump to bookmark |

### Git Status Indicators

Files in the explorer show git status with both icons and colors:

| Status | Icon | Color | Meaning |
|--------|------|-------|---------|
| Modified | ✗ | Yellow | File has changes |
| Untracked | + | Green | New file not tracked |
| Deleted | - | Red | File deleted |
| Added | ✓ | Light Green | Added to git index |
| Renamed | → | Purple | File renamed |

---

## Fuzzy Finder (Mini Pick)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-p>` | Normal | Find files |
| `<leader>f` | Normal | Live grep (search in files) |
| `<leader> ` (Space) | Normal | Buffer picker |

---

## Auto-Completion

### Insert Mode

| Key | Mode | Description |
|-----|------|-------------|
| `<CR>` | Insert | Accept completion |
| `<Tab>` | Insert | Next completion item |
| `<S-Tab>` | Insert | Previous completion item |

**Auto-trigger:** Completion menu automatically opens when typing alphanumeric characters (if LSP is attached).

---

## Auto-Close Pairs (Insert Mode)

| Key | Mode | Description |
|-----|------|-------------|
| `(` | Insert | Auto-close with `)` |
| `[` | Insert | Auto-close with `]` |
| `{` | Insert | Auto-close with `}` |
| `'` | Insert | Auto-close with `'` |
| `"` | Insert | Auto-close with `"` |

---

## Plugins

### Core Plugins
- **gitsigns.nvim** - Git integration with line/word highlighting
- **mini.git** - Git status data provider
- **mini.files** - File explorer with git status
- **mini.pick** - Fuzzy finder
- **gruvbox.nvim** - AMOLED black color scheme
- **nvim-treesitter** - Syntax highlighting
- **nvim-lspconfig** - LSP client configurations

### LSP Servers
- `nixd` - Nix
- `lua_ls` - Lua
- `ty` - Python (type checker)
- `ruff` - Python (linter/formatter)
- `vtsls` - TypeScript
- `tailwindcss` - Tailwind CSS
- `cssls` - CSS
- `oxlint` - JavaScript/TypeScript linting
- `html` - HTML
- `jsonls` - JSON
- `zls` - Zig

---

## Features

### Theme
- AMOLED black background (#000000)
- Gruvbox color palette
- Transparent tabline

### Git Integration
- **Gitsigns**: Line-level diff signs, number highlighting, line highlighting, word-level diff
- **Mini Git**: Git status tracking for file explorer
- **Mini Files**: Git status icons and colors in file browser

### Editor Features
- Auto-formatting on `<leader>F`
- Auto-completion with LSP
- Auto-close pairs for brackets and quotes
- Relative line numbers
- Persistent undo history
- Case-insensitive search

### Terminal
- Fish shell (Linux) or PowerShell (Windows)
- Terminal tabs with `<leader>ntt`

---

## Building

```bash
nix build .#default
```

Run the built Neovim:
```bash
./result/bin/nvim
```

---

## File Structure

```
nvim.config/
├── flake.nix          # Nix flake definition
├── init.lua           # Main Neovim configuration
└── README.md          # This file
```

---

## Notes

- `netrw` is disabled in favor of `mini.files`
- Leader key is set to `Space`
- Uses AMOLED black (#000000) for minimal eye strain
- Git word diff is enabled by default for fine-grained change tracking
