
vim.cmd(":set completeopt=menuone,noselect")

vim.cmd(":set noswapfile")

vim.cmd(":set noswapfile")
vim.cmd(":set backupdir=~/.vim/backup//")
vim.cmd(":set directory=~/.vim/swap//")
vim.cmd(":set undodir=~/.vim/undo//")
vim.cmd(":set path+=**")
vim.cmd(":set clipboard=unnamedplus")
vim.cmd(":set hidden")
vim.cmd(":set nobackup")
vim.cmd(":set nowritebackup")
vim.cmd(":set updatetime=300")
vim.cmd(":set shortmess+=c")
vim.cmd(":set autowrite")


vim.g.mapleader = ","

local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<leader>f','<cmd>lua require(\'telescope.builtin\').find_files()<cr>', { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg','<cmd>lua require(\'telescope.builtin\').live_grep()<cr>', { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>b','<cmd>lua require(\'telescope.builtin\').buffers()<cr>', { noremap = true})

-- vim.api.nvim_set_keymap('n', '<leader>ge',':Gblame<CR>', { noremap = true})
-- vim.api.nvim_set_keymap('n', '<leader>gs',':Git<CR>', { noremap = true})
-- vim.api.nvim_set_keymap('n', '<leader>gc',':Git commit<CR>', { noremap = true})
 vim.api.nvim_set_keymap('n', '<leader>gl',':!git pull<CR>', { noremap = true})
 vim.api.nvim_set_keymap('n', '<leader>gh',':!git push<CR>', { noremap = true})

vim.api.nvim_set_keymap('n', '<leader>gs',':LazyGit<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<c-h>',':TmuxNavigateLeft<cr>', opts)
vim.api.nvim_set_keymap('n', '<c-j>',':TmuxNavigateDown<cr>', opts)
vim.api.nvim_set_keymap('n', '<c-k>',':TmuxNavigateUp<cr>', opts)
vim.api.nvim_set_keymap('n', '<c-l>',':TmuxNavigateRight<cr>', opts)

vim.api.nvim_set_keymap('n', '<leader>cpr',':Dispatch createPr.sh<cr>', {})

vim.api.nvim_set_keymap('n', 'vv','<C-W>v', {})
vim.api.nvim_set_keymap('n', 'ss','<C-W>s', {})

vim.api.nvim_set_keymap('n', 'tt',':tabnew', {})
vim.api.nvim_set_keymap('n', 'tc',':tabclose', {})

vim.api.nvim_set_keymap('n', '<leader>n',':NvimTreeToggle<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>r',':NvimTreeFindFile<CR>', {})
vim.api.nvim_set_keymap('n', 'n','nzzzv', {noremap =true})
vim.api.nvim_set_keymap('n', 'N','Nzzzv', {noremap =true})

vim.api.nvim_set_keymap('n', 'ga','<Plug>(EasyAlign)', {})
vim.api.nvim_set_keymap('x', 'ga','<Plug>(EasyAlign)', {})

vim.api.nvim_set_keymap('i', '<leader>C','<Esc>[s1z=`]a', {})

vim.api.nvim_set_keymap('n', '<leader>sc',':set spell<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>!sc',':set nospell<CR>', {})

vim.api.nvim_set_keymap('n', '<c-s>',':w<CR>', {})
vim.api.nvim_set_keymap('v', '<c-s>','<Esc><c-s>gv', {})
vim.api.nvim_set_keymap('i', '<c-s>','<Esc><c-s>', {})



vim.api.nvim_set_keymap('i', '<C-Space>',[[compe#complete()]],  {noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap('i', '<CR>',[[compe#confirm('<CR>')]],  {noremap = true, silent = true, expr = true})

vim.api.nvim_set_keymap('n', '<leader>rS',':call RunMvnTest()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>rs',':call RunMvnThisTest(expand("%:."))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>oq',':call OpenGradleTest(expand("%:."))<CR>', opts)

-- :TestFile --debug-jvm



vim.api.nvim_set_keymap('n', '<leader>jS',':call ViewSprint() <CR>', opts) 
vim.api.nvim_set_keymap('n', '<leader>jru',':call ViewRun() <CR> ', opts)
vim.api.nvim_set_keymap('n', '<leader>js',':call SubtaskJira(expand("<cWORD>"))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>jv',':call ViewJira(expand("<cWORD>"))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>jco',':call CommentJira(expand("<cWORD>"))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>je',':call EditJira(expand("<cWORD>"))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ju',':call JiraUnassign(expand("<cWORD>"))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ja',':call JiraAssign(expand("<cWORD>"))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>jr',':call JiraReview(expand("<cWORD>"))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gf',':call GetGithubLink(expand("%:."))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ga',':call GetAlternate(expand("%:."))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gA',':call GetAlternateSplit(expand("%:."))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>jro',':call JiraOpenReview()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>jd',':call JiraDone(expand("<cWORD>"))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>jp',':call JiraProgress(expand("<cWORD>"))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>jt',':call JiraTodo(expand("<cWORD>"))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>jl',':call SubtaskJira(g:ActualTicket)<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>jm',':call MineJira()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>jn',':call JiraCreateSubtask(expand("<cWORD>"))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>jpl',':call JiraPlatform()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>jo',':call JiraOpen("<cWORD>")<CR>', opts)

vim.api.nvim_set_keymap('n', '<leader>fo','gg=G\'\'', opts)

vim.api.nvim_set_keymap('n', '<leader>a',':Rg <C-r>=expand(\'<cword>\') <CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>A',':Rg <C-r>=expand(\'<CWORD>\') <CR>', opts)

 -- :Rg LATER -g'*.md' -g'!bak'

vim.api.nvim_set_keymap('n', '<leader>ds',':VimuxRunCommand "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk; mvn -Dmaven.surefire.debug  -Dtest=".expand("%:t:r")." test --offline"<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>dt',':TestFile --debug-jvm<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>dnm,',':TestNearest --debug-jvm<CR>', {noremap = true})


vim.api.nvim_set_keymap('n', 'gx','<Plug>(openbrowser-smart-search)', opts)
vim.api.nvim_set_keymap('v', 'gx','<Plug>(openbrowser-smart-search)', opts)


vim.api.nvim_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references(); vim.cmd("copen")<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_qflist()<CR>', opts)
-- Java specific
vim.api.nvim_set_keymap("n", "<leader>oi", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
vim.api.nvim_set_keymap("v", "<leader>xv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>xv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
vim.api.nvim_set_keymap("v", "<leader>xm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>qf", "<Esc><Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)


vim.api.nvim_set_keymap("n", "tb", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.api.nvim_set_keymap("n", "co", "<cmd>lua require'dap'.continue()<CR>", opts)
vim.api.nvim_set_keymap("n", "si", "<cmd>lua require'dap'.step_into()<CR>", opts)
vim.api.nvim_set_keymap("n", "so", "<cmd>lua require'dap'.step_over()<CR>", opts)

vim.api.nvim_set_keymap("n", "od", "<cmd>lua require'dapui'.toggle()<CR>", opts)
-- If using nvim-dap
-- This requires java-debug and vscode-java-test bundles, see install steps in this README further below.

-- vim.api.nvim_set_keymap("n", "<leader>rt", "<cmd>lua require'jdtls'.test_class()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>rnm", "<cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>ctl", "<cmd>:lua require('vscode').change_style(\"light\")<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ctd", "<cmd>:lua require('vscode').change_style(\"dark\")<CR>", opts)

vim.api.nvim_set_keymap("n", "<silent> <Up>", "<cmd>:call animate#window_delta_height(10)", opts)
vim.api.nvim_set_keymap("n", "<silent> <Down>", "<cmd>:call animate#window_delta_height(-10)", opts)
vim.api.nvim_set_keymap("n", "<silent> <Left>", "<cmd>:call animate#window_delta_width(10)", opts)
vim.api.nvim_set_keymap("n", "<silent> <Right>", "<cmd>:call animate#window_delta_width(-10)", opts)


vim.api.nvim_set_keymap("n", "gx", '<cmd>:silent execute "!xdg-open " . shellescape("<cWORD>")<cr>', opts)


