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
		-- { import = "astrocommunity.editing-support.rainbow-delimieters-nvim" },
		-- { import = "astrocommunity.editing-support.refactoring-nvim" },
		-- { import = "astrocommunity.editing-support.todo-comments-nvim" },
		-- { import = "astrocommunity.file-explorer.telescope-file-browser-nvim" },
		-- { import = "astrocommunity.fuzzy-finder.telescope-nvim" },
		-- { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },
		-- { import = "astrocommunity.git.diffview-nvim" },
		-- { import = "astrocommunity.git.gitgraph-nvim" },
		-- { import = "astrocommunity.git.neogit-nvim" },
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
		-- { import = "astrocommunity.utility.telescope-live-greps-args-nvim" },

		-- Self Use Plugins --
		{
			"catppuccin/nvim",
			lazy = false,
			config = function()
				require("catppuccin").setup({
					flavour = "auto",
					background = {
						light = "latte",
						dark = "mocha",
					},
					transparent_background = false,
					show_end_of_buffer = false,
					term_colors = false,
					dim_inactive = {
						enabled = false,
						shade = "dark",
						percentage = 0.15,
					},
					no_italic = false,
					no_bold = false,
					no_underline = false,
					styles = {
						comments = { "italic" },
						conditionals = { "bold" },
						loops = {},
						functions = { "bold" },
						keywords = { "italic" },
						strings = {},
						variables = {},
						numbers = {},
						booleans = { "bold", "italic" },
						properties = {},
						types = {},
						operators = { "bold" },
						miscs = {},
					},
					color_overrides = {
						mocha = {
							base = "#11111b",
							mental = "#11111b",
						},
					},
					custom_highlights = function(colors)
						return {
							Comment = { fg = colors.subtext0 },
							CursorLineNr = { fg = colors.green, style = { "bold" } },
							Pmenu = { fg = colors.overlay2, bg = colors.none or colors.base },
							PmenuBorder = { fg = colors.surface1, bg = colors.none or colors.base },
							PmenuSel = { bg = colors.green, fg = colors.base },
							CmpItemAbbr = { fg = colors.overlay2 },
							CmpItemAbbrMatch = { fg = colors.blue, style = { "bold" } },
							CmpDoc = { link = "NormalFloat" },
							CmpDocBorder = {
								fg = colors.surface1 or colors.mantle,
								bg = colors.none or colors.mantle,
							},
						}
					end,
					default_integrations = true,
					integrations = {
						aerial = false,
						alpha = false,
						barbar = false,
						barbecue = {
							dim_dirname = false,
							bold_basename = true,
							dim_context = false,
							alt_background = false,
						},
						beacon = false,
						blink_cmp = {
							style = "bordered",
						},
						coc_nvim = false,
						colorful_winsep = {
							enabled = false,
							color = "red",
						},
						dashboard = false,
						diffview = true,
						dropbar = {
							enabled = false,
							color_mode = false,
						},
						fern = false,
						fidget = false,
						flash = false,
						fzf = false,
						gitgraph = false,
						gitsigns = true,
						grug_far = false,
						harpoon = false,
						headlines = false,
						hop = false,
						indent_blankline = {
							enabled = true,
							scope_color = "lavender",
							colored_indent_levels = true,
						},
						leap = false,
						lightspeed = false,
						lir = {
							enabled = false,
							git_status = false,
						},
						lsp_saga = false,
						markdown = true,
						markview = false,
						mason = true,
						mini = {
							enabled = false,
							indentscope_color = "",
						},
						neotree = false,
						neogit = false,
						neotest = false,
						noice = false,
						notifier = false,
						cmp = true,
						copilot_vim = false,
						dap = true,
						dap_ui = true,
						native_lsp = {
							enabled = true,
							virtual_text = {
								errors = { "italic" },
								hints = { "italic" },
								warnings = { "italic" },
								information = { "italic" },
								ok = { "italic" },
							},
							underlines = {
								errors = { "underline" },
								hints = { "underline" },
								warnings = { "underline" },
								information = { "underline" },
								ok = { "underline" },
							},
							inlay_hints = {
								background = true,
							},
						},
						navic = {
							enabled = true,
							custom_bg = "NONE",
						},
						notify = false,
						semantic_tokens = true,
						nvim_surround = false,
						nvimtree = true,
						treesitter_context = true,
						treesitter = true,
						ts_rainbow2 = false,
						ts_rainbow = false,
						ufo = true,
						window_picker = false,
						octo = false,
						overseer = false,
						pounce = false,
						rainbow_delimiters = true,
						render_markdown = true,
						snacks = {
							enabled = false,
							indent_scope_color = "text",
						},
						symbols_outline = false,
						telekasten = false,
						telescope = {
							enabled = false,
							style = "nvchad",
						},
						lsp_trouble = false,
						dadbod_ui = false,
						gitgutter = false,
						illuminate = {
							enabled = true,
							lsp = true,
						},
						sandwich = false,
						signify = false,
						vim_sneak = false,
						vimwiki = false,
						which_key = true,
					},
				})
				vim.cmd.colorscheme("catppuccin")
			end,
		},
	},
})
