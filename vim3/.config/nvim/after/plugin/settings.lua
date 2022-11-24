vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true 
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.smartindent = true
vim.opt.smartcase= true
vim.opt.hlsearch = true 
vim.opt.incsearch = true
vim.opt.wrap = true
vim.opt.ignorecase = true

vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.opt.background = "dark"

vim.api.nvim_command "colorscheme catppuccin"
-- vim.cmd("colorscheme tokyonight-night")
-- vim.cmd("colorscheme cyberpunk")

vim.opt.termguicolors = true
require 'colorizer'.setup()
