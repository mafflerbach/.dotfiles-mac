syntax on
set title
lua << EOF
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

require('plugins')

local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
require('completion_config')
require('mapping')

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.jbehave = {
    install_info = {
        url = "/home/maren/development/tree-sitter-jbehave", -- local path or git repo
        files = {"src/parser.c"}
        },
    filetype = "story" -- if filetype does not agrees with parser name
    }


require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require("dap_configuration")
require("dap2")
require("jdtls_config")
require("dapui").setup()
require('gitsigns').setup()
require('rust-tools').setup({})

-- these are all the default values

EOF

lua <<EOF
-- following options are the default
require'nvim-tree'.setup {
    -- disables netrw completely
    disable_netrw       = true,
    -- hijack netrw window on startup
    hijack_netrw        = true,
    -- open the tree when running this setup function
    open_on_setup       = false,
    -- will not open on setup if the filetype is in this list
    ignore_ft_on_setup  = {},
    -- closes neovim automatically when the tree is the last **WINDOW** in the view
    auto_close          = false,
    -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
    open_on_tab         = false,
    -- hijack the cursor in the tree to put it at the start of the filename
    hijack_cursor       = false,
    -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually) 
    update_cwd          = false,
    -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    update_focused_file = {
        -- enables the feature
    enable      = false,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
    },
-- configuration options for the system open command (`s` in the tree by default)
system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
    },

view = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
        -- custom only false will merge the list with the default mappings
        -- if true, it will only use your list to set the mappings
        custom_only = false,
        -- list of mappings to set on the tree manually
        list = {}
        }
    }
}



local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)



EOF





nnoremap <silent> <leader>co :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>so :lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>si :lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>soo :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>tb :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>rc :lua require'dap'.run_to_cursor()<CR>

nnoremap <silent> <leader> :call GotoWindow("DAP Breakpoints") <CR>
nnoremap <silent> <leader> :call GotoWindow("DAP Watches") <CR>
nnoremap <silent> <leader> :call GotoWindow("DAP Scopes") <CR>

nnoremap <silent> <leader>m :MaximizerToggle<CR>

nmap <leader>fj :%!python -m json.tool<CR>
" format visual selected json
vmap <leader>fj :'<,'> call BeautifyMvnLog()<CR>

vmap <leader>de :'<,'> call DecryptMessage()<CR>

nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(10)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(-10)<CR>

map <leader>1 "ayiW
map <leader>2 "syiW
map <leader>3 "qyiW

map <leader>pri :!lp "%" -o print-quality=3
map <leader>rp :cfdo %s/<C-R>a/<C-R>s/g

map <F2> :lua require('rest-nvim').run()<CR>


nmap gx :silent execute "!xdg-open " . shellescape("<cWORD>")<CR>


map <leader>date :put =strftime('# %a %d %b %Y #')

let g:ActualTicket = "INTS-5866"

"
" https://google.com


" let g:compe.source.vim_dadbod_completion = v:true

let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:notoire_folders = ['~/.notes']

colorscheme wal


let &l:errorformat =
            \ '%E%\m:%\%%(compileJava%\|compileTarget%\)%f:%l: error: %m,' .
            \ '%E%f:%l: error: %m,' .
            \ '%Z%p^,' .
            \ '%-G%.%#'


let test#strategy = "vimux"


if filereadable(expand("build.gradle"))
    let test#java#runner = 'gradletest'
endif

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END


:so /home/maren/.dotfiles/vim2/.config/nvim/functions.vim

au BufRead,BufNewFile *.logs set filetype=logs

au BufNewFile,BufRead *.pre call SetVimPresentationMode()
function SetVimPresentationMode()
set filetype=pre
    nnoremap <buffer> <Right> :n <CR>
    nnoremap <buffer> <Left> :N <CR>

    nnoremap <buffer> <Left> :N <CR>

nmap <leader>h :.!toilet -w 200 -f emboss<CR>
nmap <leader>H :.!toilet -w 200 -f smblock<CR>
nmap <leader>b :.!toilet -w 200 -f term -F border<CR>

nmap <leader>5 :Goyo 70%x100%<CR>
nmap <leader>0 :Goyo 100%x100%<CR>


endfunction



" pick the first entriy of the spell correction
imap <leader>C <Esc>[s1z=`]a


set rtp+=~/.fzf

