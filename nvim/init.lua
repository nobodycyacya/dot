-- https://github.com/boltlessengineer/NativeVim
-- https://github.com/HCY-ASLEEP/NVIM-Config
-- https://github.com/LazyVim/LazyVim
-- https://github.com/AstroNvim/AstroNvim
-- https://github.com/NvChad/NvChad
-- https://github.com/ayamir/nvimdots
-- https://github.com/nvim-lua/kickstart.nvim

-- BUILTIN
vim.opt.clipboard = "unnamedplus,unnamed"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wrap = false
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.undofile = false
vim.opt.background = "dark"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.api.nvim_set_keymap("n", "<leader>CR", "<cmd>source $MYVIMRC<cr>", { desc = "Reload config" })
vim.api.nvim_set_keymap("n", "<leader>CE", "<cmd>edit $MYVIMRC<cr>", { desc = "Edit config" })
vim.api.nvim_set_keymap("i", "jk", "<esc>", { desc = "Back to Normal Mode" })
vim.api.nvim_set_keymap("v", "jk", "<esc>", { desc = "Stop Visual Mode" })
vim.api.nvim_set_keymap("c", "jk", "<c-c>", { desc = "Stop Input Commands" })
vim.api.nvim_set_keymap("i", "<c-a>", "<home>", { desc = "Move to Start" })
vim.api.nvim_set_keymap("v", "<c-a>", "<home>", { desc = "Move to Start" })
vim.api.nvim_set_keymap("c", "<c-a>", "<home>", { desc = "Move to Start" })
vim.api.nvim_set_keymap("i", "<c-e>", "<end>", { desc = "Move to End" })
vim.api.nvim_set_keymap("v", "<c-e>", "<end>", { desc = "Move to End" })
vim.api.nvim_set_keymap("c", "<c-e>", "<end>", { desc = "Move to End" })
vim.api.nvim_set_keymap("n", "<c-h>", "<c-w>h", { desc = "Move to Left Window" })
vim.api.nvim_set_keymap("n", "<c-j>", "<c-w>j", { desc = "Move to Down Window" })
vim.api.nvim_set_keymap("n", "<c-k>", "<c-w>k", { desc = "Move to Up Window" })
vim.api.nvim_set_keymap("n", "<c-l>", "<c-w>l", { desc = "Move to Right Window" })
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("ChangeTabSizeWithSpecificFileType", { clear = true }),
	pattern = { "python", "json", "jsonc" },
	callback = function()
		vim.bo.shiftwidth = 4
		vim.bo.tabstop = 4
		vim.bo.softtabstop = 4
	end,
})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 2000 })
	end,
})
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("LastLocation", { clear = true }),
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
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("CloseWithQ", { clear = true }),
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"snacks_win",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
			buffer = event.buf,
			silent = true,
			desc = "Quit buffer",
		})
	end)
end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("WrapWithSpecificType", { clear = true }),
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("AutoCreateDirWhenSaveFile", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("DisabledAutoCommentNextLine", { clear = true }),
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o", "c" })
	end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("DisableSyntaxWithLargeFile", { clear = true }),
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(buf))
		if file_size > 1.5 * 1024 * 1024 then
			vim.cmd("syntax clear")
		end
	end,
})
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("DisableMouseSupport", { clear = true }),
	callback = function()
		vim.opt.mouse = ""
	end,
})

-- lazy.nvim
if not vim.loop.fs_stat(vim.fn.stdpath("data") .. "/lazy/lazy.nvim") then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
	})
end
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
require("lazy").setup({
	performance = {
		rtp = {
			disabled_plugins = {
				"editorconfig",
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"man",
				"matchit",
				"matchparen",
				"osc52",
				"tar",
				"tarPlugin",
				"rplugin",
				"rrhelper",
				"shada",
				"spellfile",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
	spec = {
		-- LazyVim
		{
			"LazyVim/LazyVim",
		},
		{ import = "lazyvim.plugins" },
		{ import = "lazyvim.plugins.extras.coding.luasnip" },
		{ import = "lazyvim.plugins.extras.coding.nvim-cmp" },
		{ import = "lazyvim.plugins.extras.dap.core" },
		{ import = "lazyvim.plugins.extras.editor.aerial" },
		{ import = "lazyvim.plugins.extras.editor.illuminate" },
		{ import = "lazyvim.plugins.extras.editor.navic" },
		{ import = "lazyvim.plugins.extras.editor.overseer" },
		{ import = "lazyvim.plugins.extras.formatting.black" },
		{ import = "lazyvim.plugins.extras.formatting.prettier" },
		{ import = "lazyvim.plugins.extras.lang.clangd" },
		{ import = "lazyvim.plugins.extras.lang.cmake" },
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
		{ import = "lazyvim.plugins.extras.lsp.none-ls" },
		{ import = "lazyvim.plugins.extras.test.core" },
		{ import = "lazyvim.plugins.extras.ui.treesitter-context" },
		-- AstroNvim
		-- {
		-- 	"AstroNvim/AstroNvim",
		-- 	version = "^5",
		-- },
		-- { import = "astronvim.plugins" },
		-- {
		-- 	"AstroNvim/astrocommunity",
		-- },
		-- { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
		-- { import = "astrocommunity.bars-and-lines.statuscol-nvim" },
		-- { import = "astrocommunity.bars-and-lines.vim-illuminate" },
		-- { import = "astrocommunity.code-runner.overseer-nvim" },
		-- { import = "astrocommunity.color.modes-nvim" },
		-- { import = "astrocommunity.completion.cmp-cmdline" },
		-- { import = "astrocommunity.completion.cmp-nvim-lua" },
		-- { import = "astrocommunity.completion.nvim-cmp" },
		-- { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
		-- { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
		-- { import = "astrocommunity.diagnostics.trouble-nvim" },
		-- { import = "astrocommunity.editing-support.bigfile-nvim" },
		-- { import = "astrocommunity.editing-support.nvim-treesitter-context" },
		-- { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
		-- { import = "astrocommunity.editing-support.todo-comments-nvim" },
		-- { import = "astrocommunity.editing-support.zen-mode-nvim" },
		-- { import = "astrocommunity.git.diffview-nvim" },
		-- { import = "astrocommunity.indent.indent-rainbowline" },
		-- { import = "astrocommunity.indent.snacks-indent-hlchunk" },
		-- { import = "astrocommunity.lsp.lsp-signature-nvim" },
		-- { import = "astrocommunity.lsp.lspsaga-nvim" },
		-- { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
		-- { import = "astrocommunity.motion.vim-matchup" },
		-- { import = "astrocommunity.pack.bash" },
		-- { import = "astrocommunity.pack.cmake" },
		-- { import = "astrocommunity.pack.cpp" },
		-- { import = "astrocommunity.pack.go" },
		-- { import = "astrocommunity.pack.lua" },
		-- { import = "astrocommunity.pack.markdown" },
		-- { import = "astrocommunity.pack.python" },
		-- { import = "astrocommunity.pack.quarto" },
		-- { import = "astrocommunity.pack.sql" },
		-- { import = "astrocommunity.pack.toml" },
		-- { import = "astrocommunity.pack.typescript-all-in-one" },
		-- { import = "astrocommunity.pack.yaml" },
		-- { import = "astrocommunity.programming-language-support.csv-vim" },
		-- { import = "astrocommunity.snippet.nvim-snippets" },
		-- { import = "astrocommunity.syntax.vim-cool" },
		-- { import = "astrocommunity.test.neotest" },
		-- { import = "astrocommunity.utility.neodim" },
	},
})
