-- sweet sweet macchiato
vim.cmd.colorscheme("catppuccin-macchiato")

-- Line numbers, absolute
vim.opt.nu = true
vim.opt.relativenumber = false

-- tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- left / right wraps to prev/next line
vim.opt.whichwrap = "b,s,h,l,<,>,~,[,]"

-- no visibility wraps
vim.opt.wrap = false

vim.opt.incsearch = true

-- 24 bits of love
vim.opt.termguicolors = true
