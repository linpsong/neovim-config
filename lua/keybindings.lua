-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

vim.g.mapleader = " "

local opt = {
	noremap = true,
	silent = true,
}
local map = vim.keymap.set

map("n", "sp", ":split<CR>", opt)
map("n", "vsp", ":vsplit<CR>", opt)
