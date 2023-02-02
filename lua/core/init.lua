local function set_leader_key()
	vim.keymap.set("", "<Space>", "<Nop>")
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
end

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})


local function load_core()
	set_leader_key()
	require("core.settings")
	require("core.lazy")
	require'misc.keymaps'
	require("misc.colorschemes").set_theme("rosepine")
end


load_core()

