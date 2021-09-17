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


if has('nvim-0.5')
    augroup lsp
        au!
        au FileType java lua require'jdtls_config'.setup()
    augroup end
endif


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
let g:nvim_tree_ignore = [ '.git', 'node_modules' ]

lua <<EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.jbehave = {
    install_info = {
        url = "/home/maren/development/tree-sitter-jbehave", -- local path or git repo
        files = {"src/parser.c"}
        },
    filetype = "story" -- if filetype does not agrees with parser name
    }


    require'nvim-treesitter.configs'.setup {highlight = {enable = true}}
    require("dap_configuration")
    require("dapui").setup()
    require("bubbles")
    require('gitsigns').setup()
    require('rust-tools').setup({})

-- these are all the default values

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

    let g:nvim_tree_disable_netrw = 0
    let g:nvim_tree_hijack_netrw = 0
    let g:ActualTicket = "INTS-5662"
    " https://google.com


    " let g:compe.source.vim_dadbod_completion = v:true

    let g:netrw_nogx = 1 " disable netrw's gx mapping.
    let g:notoire_folders = ['~/.notes']

    colorscheme wal

