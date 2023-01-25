lua << EOF
local execute = vim.api.nvim_command
vim.opt.termguicolors = true
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

require('plugins')
require("nvim-lsp-installer").setup {}

require("cfg-cmp")
require("cfg-neodev")
require("cfg-lsp")
require("cfg-gh")
require("cfg-lualine")
require("cfg-nvimtree")
require("cfg-telescope")
require("cfg-dap")
require("cfg-dap-ui")
require("cfg-gitsigns")
require("cfg-rest")
require("cfg-rusttools")
require("cfg-telekasten")
require("cfg-tokyonight")
require("cfg-treesitter")
require("jira")
require("kube")
require("helm")
require("sere")
require("json-formatter")
require("java-dependencies")
require("jbehave")
require("youtube")
require("mappings")
require("cfg-vimtest")
require("cfg-neogit")
require("cfg-notify")
require("cfg-catppuccin")
require("symbols-outline").setup()
require("nvim-dap-virtual-text").setup()

-- local neogit = require('neogit')
-- neogit.setup {}

EOF


:so /Users/maren/.dotfiles/vim3/.config/nvim/viml/functions.vim
:so /Users/maren/.dotfiles/vim3/.config/nvim/viml/mappings.vim

"let test#java#runner = 'gradletest'
let test#strategy = "vimux"


let g:actualticket = ""
let g:mkdp_markdown_css = '/Users/maren/.dotfiles/vim3/.config/nvim/markdown/index.css'
" hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=dark guifg=white
