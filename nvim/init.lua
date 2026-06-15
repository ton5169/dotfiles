require("core.options")
require("core.keymaps")

-- ============================================================
-- PLUGIN MANAGER INTRO
-- ============================================================
do
	-- `vim.pack` is a plugin manager
	--  See `:help vim.pack`, `:help vim.pack-examples` or the
	--  excellent blog post from the creator of vim.pack and mini.nvim:
	--  https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack

	local function run_build(name, cmd, cwd)
		local result = vim.system(cmd, { cwd = cwd }):wait()
		if result.code ~= 0 then
			local stderr = result.stderr or ""
			local stdout = result.stdout or ""
			local output = stderr ~= "" and stderr or stdout
			if output == "" then
				output = "No output from build command."
			end
			vim.notify(("Build failed for %s:\n%s"):format(name, output), vim.log.levels.ERROR)
		end
	end

	-- This autocommand runs after a plugin is installed or updated and
	--  runs the appropriate build command for that plugin if necessary.
	--
	-- See `:help vim.pack-events`
	vim.api.nvim_create_autocmd("PackChanged", {
		callback = function(ev)
			local name = ev.data.spec.name
			local kind = ev.data.kind
			if kind ~= "install" and kind ~= "update" then
				return
			end

			if name == "telescope-fzf-native.nvim" and vim.fn.executable("make") == 1 then
				run_build(name, { "make" }, ev.data.path)
				return
			end

			if name == "LuaSnip" then
				if vim.fn.has("win32") ~= 1 and vim.fn.executable("make") == 1 then
					run_build(name, { "make", "install_jsregexp" }, ev.data.path)
				end
				return
			end

			if name == "nvim-treesitter" then
				if not ev.data.active then
					vim.cmd.packadd("nvim-treesitter")
				end
				vim.cmd("TSUpdate")
				return
			end
		end,
	})
end

-- ============================================================
-- PLUGINS
-- ============================================================
do
	-- [[Colorscheme]]
	require("plugins.colortheme")
	vim.cmd.colorscheme("tokyonight-night")

	-- [[NeoTree]]
	require("plugins.neotree")

	-- [[Bufferline]]
	require("plugins.bufferline")

	-- [[LuaLine]]
	require("plugins.lualine")

	-- [[TreeSitter]]
	require("plugins.treesitter")

	-- [[Telescope]]
	require("plugins.telescope")

	-- [[Which-Key]]
	require("plugins.which-key")

	-- [[ LSP Configuration ]]
	require("plugins.lsp")

	-- [[ Autocompletion ]]
	require("plugins.autocompletion")

	-- [[ Autoformatting ]]
	require("plugins.autoformatting")
end
