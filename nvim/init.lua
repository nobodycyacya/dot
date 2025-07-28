-- [[ REFERENCES ]] --
-- https://github.com/HCY-ASLEEP/NVIM-Config
-- https://github.com/LazyVim/LazyVim
-- https://github.com/AstroNvim/AstroNvim
-- https://github.com/nvim-lua/kickstart.nvim

-- [[ OPTIONS ]] --
vim.opt.autoread = true
vim.opt.number = true
vim.opt.relativenumber = true

-- [[ KEYBINDINGS ]] --
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

-- [[ AUTOCMD ]] --
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("restore_position", { clear = true }),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlighted_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 2000 })
	end,
})

-- [[ PLUGINS ]] --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	spec = {
		-- LazyVim --
		{
			"LazyVim/LazyVim",
			opts = {
				colorscheme = "tokyonight-night",
			},
		},
		{ import = "lazyvim.plugins" },
		{ import = "lazyvim.plugins.extras.coding.luasnip" },
		{ import = "lazyvim.plugins.extras.coding.nvim-cmp" },
		{ import = "lazyvim.plugins.extras.dap.core" },
		{ import = "lazyvim.plugins.extras.dap.nlua" },
		{ import = "lazyvim.plugins.extras.editor.aerial" },
		{ import = "lazyvim.plugins.extras.editor.illuminate" },
		{ import = "lazyvim.plugins.extras.editor.navic" },
		{ import = "lazyvim.plugins.extras.editor.neo-tree" },
		{ import = "lazyvim.plugins.extras.editor.overseer" },
		{ import = "lazyvim.plugins.extras.editor.refactoring" },
		{ import = "lazyvim.plugins.extras.editor.telescope" },
		{ import = "lazyvim.plugins.extras.formatting.black" },
		{ import = "lazyvim.plugins.extras.formatting.prettier" },
		{ import = "lazyvim.plugins.extras.lang.clangd" },
		{ import = "lazyvim.plugins.extras.lang.go" },
		{ import = "lazyvim.plugins.extras.lang.json" },
		{ import = "lazyvim.plugins.extras.lang.markdown" },
		{ import = "lazyvim.plugins.extras.lang.python" },
		{ import = "lazyvim.plugins.extras.lang.r" },
		{ import = "lazyvim.plugins.extras.lang.sql" },
		{ import = "lazyvim.plugins.extras.lang.toml" },
		{ import = "lazyvim.plugins.extras.lang.typescript" },
		{ import = "lazyvim.plugins.extras.lang.yaml" },
		{ import = "lazyvim.plugins.extras.linting.eslint" },
		{ import = "lazyvim.plugins.extras.lsp.neoconf" },
		{ import = "lazyvim.plugins.extras.lsp.none-ls" },
		{ import = "lazyvim.plugins.extras.test.core" },
		{ import = "lazyvim.plugins.extras.ui.indent-blankline" },
		{ import = "lazyvim.plugins.extras.ui.treesitter-context" },
		{ import = "lazyvim.plugins.extras.util.octo" },
		{ import = "lazyvim.plugins.extras.util.project" },

		-- AstroNvim --
		-- {
		-- 	"AstroNvim/AstroNvim",
		-- 	version = "^5",
		-- },
		-- { import = "astronvim.plugins" },
		-- {
		-- 	"AstroNvim/astrocommunity",
		-- },
		-- { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
		-- { import = "astrocommunity.bars-and-lines.scope-nvim" },
		-- { import = "astrocommunity.bars-and-lines.statuscol-nvim" },
		-- { import = "astrocommunity.bars-and-lines.vim-illuminate" },
		-- { import = "astrocommunity.code-runner.overseer-nvim" },
		-- { import = "astrocommunity.comment.ts-comments-nvim" },
		-- { import = "astrocommunity.completion.cmp-cmdline" },
		-- { import = "astrocommunity.completion.cmp-nvim-lua" },
		-- { import = "astrocommunity.completion.nvim-cmp-buffer-lines" },
		-- { import = "astrocommunity.completion.nvim-cmp" },
		-- { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
		-- { import = "astrocommunity.debugging.nvim-dap-view" },
		-- { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
		-- { import = "astrocommunity.debugging.telescope-dap-nvim" },
		-- { import = "astrocommunity.diagnostics.trouble-nvim" },
		-- { import = "astrocommunity.editing-support.bigfile-nvim" },
		-- { import = "astrocommunity.editing-support.nvim-treesitter-context" },
		-- { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
		-- { import = "astrocommunity.editing-support.refactoring-nvim" },
		-- { import = "astrocommunity.editing-support.todo-comments-nvim" },
		-- { import = "astrocommunity.file-explorer.telescope-file-browser-nvim" },
		-- { import = "astrocommunity.fuzzy-finder.telescope-nvim" },
		-- { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },
		-- { import = "astrocommunity.git.diffview-nvim" },
		-- { import = "astrocommunity.git.gitgraph-nvim" },
		-- { import = "astrocommunity.git.neogit" },
		-- { import = "astrocommunity.git.octo-nvim" },
		-- { import = "astrocommunity.indent.indent-blankline-nvim" },
		-- { import = "astrocommunity.indent.snacks-indent-hlchunk" },
		-- { import = "astrocommunity.lsp.lsp-signature-nvim" },
		-- { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
		-- { import = "astrocommunity.motion.vim-matchup" },
		-- { import = "astrocommunity.pack.bash" },
		-- { import = "astrocommunity.pack.cpp" },
		-- { import = "astrocommunity.pack.eslint" },
		-- { import = "astrocommunity.pack.go" },
		-- { import = "astrocommunity.pack.json" },
		-- { import = "astrocommunity.pack.lua" },
		-- { import = "astrocommunity.pack.markdown" },
		-- { import = "astrocommunity.pack.python" },
		-- { import = "astrocommunity.pack.sql" },
		-- { import = "astrocommunity.pack.typescript-all-in-one" },
		-- { import = "astrocommunity.pack.xml" },
		-- { import = "astrocommunity.pack.yaml" },
		-- { import = "astrocommunity.programming-language-support.csv-vim" },
		-- { import = "astrocommunity.project.project-nvim" },
		-- { import = "astrocommunity.scrolling.neoscroll-nvim" },
		-- { import = "astrocommunity.scrolling.nvim-scrollbar" },
		-- { import = "astrocommunity.snippet.nvim-snippets" },
		-- { import = "astrocommunity.test.neotest" },
		-- { import = "astrocommunity.utility.neodim" },
		-- { import = "astrocommunity.utility.telescope-fzy-native-nvim" },
		-- { import = "astrocommunity.utility.telescope-live-grep-args-nvim" },
	},
})
