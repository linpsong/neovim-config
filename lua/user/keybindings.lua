-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

local opt = {
	noremap = true,
	silent = true,
}
local map = vim.keymap.set

map("n", "sp", ":split<cr>", opt)
map("n", "vsp", ":vsplit<cr>", opt)

-- nvim-tree
map("n", "nt", ":NvimTreeOpen<CR>")
map("n", "nq", ":NvimTreeClose<CR>")
