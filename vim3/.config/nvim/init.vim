lua << EOF
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

require('plugins')
require("nvim-lsp-installer").setup {}

require("cfg-cmp")
require("cfg-lsp")
require("cfg-lualine")
require("cfg-nvimtree")
require("cfg-telescope")
require("cfg-dap")
require("cfg-dap-ui")

require("mappings")
EOF


:so /home/maren/.dotfiles/vim3/.config/nvim/viml/functions.vim
:so /home/maren/.dotfiles/vim3/.config/nvim/viml/mappings.vim

let test#java#runner = 'gradletest'

let g:actualticket = "ints-6068"
colorscheme wal

