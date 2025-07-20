-- [[ REFERENCES ]]
-- https://github.com/HCY-ASLEEP/NVIM-Config
-- https://github.com/LazyVim/LazyVim
-- https://github.com/AstroNvim/AstroNvim
-- https://github.com/nvim-lua/kickstart.nvim

-- [[ OPTIONS ]]
vim.opt.autoread = true
vim.opt.number = true
vim.opt.relativenumber = true

-- [[ KEYBINDINGS ]]
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

-- [[ AUTOCMD ]]
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
