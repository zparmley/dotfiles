-- leader key comes first
vim.g.mapleader = ","

-- No default file explorer
-- https://github.com/nvim-tree/nvim-tree.lua/tree/v1.15.0?tab=readme-ov-file#install
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- lazy (plugins)
require("zparmley.lazy_init")

-- key remaps and settings
require("zparmley.remap")
require("zparmley.set")
