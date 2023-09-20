vim.g.mapleader = " "

local opt = {
	noremap = true,
	silent = true,
}

vim.keymap.set("n", "sp", ":split<CR>", opt)
vim.keymap.set("n", "vsp", ":vsplit<CR>", opt)
