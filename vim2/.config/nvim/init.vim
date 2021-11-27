syntax on
lua << EOF
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

require('plugins')
EOF



augroup jdtls_lsp
    autocmd!
    autocmd FileType java lua require'jdtls_config'.setup()
augroup end

lua << EOF

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
        }
    }

local function setup_servers()
require'lspinstall'.setup()
local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
    require'lspconfig'[server].setup{
    capabilities = capabilities,
    }
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
setup_servers() -- reload installed servers
vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

require "lsp_signature".setup()


EOF

lua require('jdtls_config')
lua require('completion_config')
lua require('mapping')

:so /home/maren/.dotfiles/vim2/.config/nvim/functions.vim

lua <<EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.jbehave = {
    install_info = {
        url = "/home/maren/development/tree-sitter-jbehave", -- local path or git repo
        files = {"src/parser.c"}
        },
    filetype = "story" -- if filetype does not agrees with parser name
    }


require'nvim-treesitter.configs'.setup {
    highlight = {enable = true},
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }

}
require("dap_configuration")
require("dapui").setup()
require("bubbles")
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

nmap gx :silent execute "!xdg-open " . shellescape("<cWORD>")<CR>


map <leader>date :put =strftime('# %a %d %b %Y #')

let g:ActualTicket = "INTS-5335"
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


set rtp+=~/.fzf
