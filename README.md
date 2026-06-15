Fonts & icons:

https://github.com/ryanoasis/nerd-fonts/

To change font for PowerShell:

Right Click on terminal -> Settings -> Profile -> Appearance -> Font Face

Font used:

JetBrainsMono Nerd Font Mono

NVIM folder location:

%LOCALAPPDATA%\nvim\

---

## Neovim keymaps

Leader: `<Space>` (`mapleader` and `maplocalleader`)

Modes: `n` = Normal, `i` = Insert, `v` = Visual, `x` = Visual block

### Core (`nvim/lua/core/keymaps.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `<Space>` | n, v | Disable default space behavior |
| `j` / `k` | n | Move through wrapped lines (`gj` / `gk` when count is 0) |
| `<Esc>` | n | Clear search highlight |
| `<C-s>` | n | Save file |
| `<leader>sn` | n | Save without auto-formatting |
| `<C-q>` | n | Quit |
| `x` | n | Delete char without yanking |
| `<C-d>` / `<C-u>` | n | Scroll half-page and center cursor |
| `n` / `N` | n | Next/prev search match and center |
| `<Up>` / `<Down>` | n | Resize window height |
| `<Left>` / `<Right>` | n | Resize window width |
| `<Tab>` / `<S-Tab>` | n | Next / previous buffer |
| `<C-i>` | n | Jump forward (restores default after Tab remap) |
| `<leader>x` | n | Close buffer (`Bdelete!`) |
| `<leader>b` | n | New empty buffer |
| `<leader>+` / `<leader>-` | n | Increment / decrement number |
| `<leader>v` | n | Vertical split |
| `<leader>h` | n | Horizontal split |
| `<leader>se` | n | Equalize split sizes |
| `<leader>xs` | n | Close current split |
| `<C-k>` / `<C-j>` / `<C-h>` / `<C-l>` | n | Focus split above / below / left / right |
| `<leader>to` | n | New tab |
| `<leader>tx` | n | Close tab |
| `<leader>tn` / `<leader>tp` | n | Next / previous tab |
| `<leader>lw` | n | Toggle line wrap |
| `jk` / `kj` | i | Exit insert mode |
| `<` / `>` | v | Indent and keep selection |
| `<A-j>` / `<A-k>` | v | Move selection down / up |
| `p` | v | Paste without overwriting register |
| `<leader>j` | n | Replace word under cursor |
| `<leader>y` | n, v | Yank to system clipboard |
| `<leader>Y` | n | Yank entire line to system clipboard |
| `<leader>do` | n | Toggle diagnostics on/off |
| `[d` / `]d` | n | Previous / next diagnostic (with float) |
| `<leader>d` | n | Open diagnostic float |
| `<leader>q` | n | Open diagnostics in location list |
| `<leader>sS` | n | Save session to `.session.vim` |
| `<leader>sl` | n | Load session from `.session.vim` |

### Telescope — global (`nvim/lua/plugins/telescope.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>sh` | n | Search help tags |
| `<leader>sk` | n | Search keymaps |
| `<leader>sf` | n | Find files |
| `<leader>ss` | n | Telescope builtin picker |
| `<leader>sw` | n | Grep word under cursor |
| `<leader>sg` | n | Live grep |
| `<leader>sd` | n | Search diagnostics |
| `<leader>sr` | n | Resume last search |
| `<leader>s.` | n | Recent files |
| `<leader>s/` | n | Live grep in open files |
| `<leader>/` | n | Fuzzy find in current buffer |
| `<leader><leader>` | n | Find buffers |

### Telescope — picker (`telescope.setup` defaults)

Insert mode inside a Telescope prompt:

| Key | Action |
| --- | --- |
| `<C-k>` | Previous result |
| `<C-j>` | Next result |
| `<C-l>` | Open selection |
| `<C-/>` | Show picker help (Telescope default; not customized) |
| `?` | Show picker help in normal mode (Telescope default; not customized) |

### LSP — buffer-local (`nvim/lua/plugins/lsp.lua`, on `LspAttach`)

| Key | Mode | Action |
| --- | --- | --- |
| `grn` | n | Rename symbol |
| `gra` | n, x | Code action |
| `grD` | n | Go to declaration |
| `<leader>th` | n | Toggle inlay hints (when LSP supports them) |

### Conform — format (`nvim/lua/plugins/autoformatting.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>f` | n, v | Format buffer (async) |

Format-on-save is also enabled via `conform.nvim` (no extra keymap).

### blink.cmp — completion (`nvim/lua/plugins/autocompletion.lua`)

Uses `preset = 'default'` plus custom overrides. Active in insert mode when the completion menu is open unless noted.

| Key | Action |
| --- | --- |
| `<C-j>` | Select next item (custom; overrides preset signature-help on `<C-k>`/`<C-j>`) |
| `<C-k>` | Select previous item (custom) |
| `<CR>` | Accept completion (custom; overrides preset `<C-y>`) |
| `<C-c>` | Show completion menu (custom) |
| `<Tab>` / `<S-Tab>` | Move through snippet expansion (preset default) |
| `<C-Space>` | Open menu, or docs if menu is already open (preset default) |
| `<C-n>` / `<C-p>` | Next / previous item (preset default) |
| `<Up>` / `<Down>` | Next / previous item (preset default) |
| `<C-e>` | Hide menu (preset default) |

### which-key (`nvim/lua/plugins/which-key.lua`)

No keymaps defined. Registers groups for the popup: `<leader>s` (Search), `<leader>t` (Toggle), `<leader>h` (Git Hunk — no gitsigns plugin installed), `gr` (LSP Actions).

### Neo-tree — global (`nvim/lua/plugins/neotree.lua`)

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>w` | n | Toggle file explorer (float) |
| `<leader>e` | n | Toggle file explorer (left sidebar) |
| `<leader>ngs` | n | Open git status (float) |
| `\` | n | Reveal current file in Neo-tree |

### Neo-tree — window (when Neo-tree is focused)

Shared mappings (`window.mappings`):

| Key | Action |
| --- | --- |
| `<Space>` | Toggle node |
| `<2-LeftMouse>` | Open |
| `<CR>` | Open |
| `<Esc>` | Cancel |
| `P` | Toggle preview (float) |
| `l` | Open |
| `S` | Open in horizontal split |
| `s` | Open in vertical split |
| `t` | Open in new tab |
| `w` | Open with window picker |
| `C` | Close node |
| `z` | Close all nodes |
| `a` | Add file |
| `A` | Add directory |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `c` | Copy |
| `m` | Move |
| `q` | Close Neo-tree window |
| `R` | Refresh |
| `?` | Show help |
| `<` / `>` | Previous / next source |
| `i` | Show file details |

Filesystem source (`filesystem.window.mappings`):

| Key | Action |
| --- | --- |
| `<BS>` | Navigate up |
| `.` | Set root to current folder |
| `H` | Toggle hidden files |
| `/` | Fuzzy finder |
| `D` | Fuzzy finder (directories) |
| `#` | Fuzzy sorter |
| `f` | Filter on submit |
| `<C-x>` | Clear filter |
| `[g` / `]g` | Previous / next git-modified file |
| `o` + `c` | Order by created |
| `o` + `d` | Order by diagnostics |
| `o` + `g` | Order by git status |
| `o` + `m` | Order by modified |
| `o` + `n` | Order by name |
| `o` + `s` | Order by size |
| `o` + `t` | Order by type |

Filesystem fuzzy finder (`filesystem.window.fuzzy_finder_mappings`):

| Key | Action |
| --- | --- |
| `<Down>` / `<C-n>` | Move cursor down |
| `<Up>` / `<C-p>` | Move cursor up |

Buffers source (`buffers.window.mappings`):

| Key | Action |
| --- | --- |
| `bd` | Delete buffer |
| `<BS>` | Navigate up |
| `.` | Set root |
| `o` + `c` / `d` / `m` / `n` / `s` / `t` | Order by created / diagnostics / modified / name / size / type |

Git status source (`git_status.window.mappings`):

| Key | Action |
| --- | --- |
| `A` | Git add all |
| `gu` | Git unstage file |
| `ga` | Git add file |
| `gr` | Git revert file |
| `gc` | Git commit |
| `gp` | Git push |
| `gg` | Git commit and push |
| `o` + `c` / `d` / `m` / `n` / `s` / `t` | Order by created / diagnostics / modified / name / size / type |

### Plugins without custom keymaps

These plugins are configured in this repo but do not define keymaps in config:

| Plugin | Notes |
| --- | --- |
| `bufferline.nvim` | Mouse only: left = select buffer, right/middle = close |
| `lualine.nvim` | Status line only |
| `tokyonight.nvim` | Colorscheme only |
| `nvim-treesitter` | Syntax/highlighting only |
| `fidget.nvim` | LSP progress UI only |
| `mason.nvim` / `mason-tool-installer.nvim` | `:Mason` UI (`g?` for help in Mason menu — plugin default, not configured here) |
| `LuaSnip` | Snippets engine; no custom keymaps (see blink.cmp for completion keys) |
| `plenary.nvim`, `nui.nvim`, `nvim-web-devicons`, `image.nvim`, `nvim-window-picker` | Dependencies for Neo-tree / Telescope |
| `vim-bbye` | Used by bufferline close command |
