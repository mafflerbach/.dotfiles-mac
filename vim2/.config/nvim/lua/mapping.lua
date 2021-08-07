vim.cmd(":set completeopt=menuone,noselect")

vim.cmd(":set noswapfile")

vim.cmd(":set noswapfile")
vim.cmd(":set backupdir=~/.vim/backup//")
vim.cmd(":set directory=~/.vim/swap//")
vim.cmd(":set undodir=~/.vim/undo//")
vim.cmd(":set path+=**")
vim.cmd(":set clipboard=unnamedplus")
vim.cmd(":set nu")
vim.cmd(":set number relativenumber")
vim.cmd(":set hlsearch")
vim.cmd(":set incsearch")
vim.cmd(":set ignorecase")
vim.cmd(":set smartcase")
vim.cmd(":set hidden")
vim.cmd(":set nobackup")
vim.cmd(":set nowritebackup")
vim.cmd(":set updatetime=300")
vim.cmd(":set shortmess+=c")
vim.cmd(":set numberwidth=4 ")
vim.cmd(":set autowrite")
vim.cmd(":set tabstop=4 softtabstop=4 expandtab shiftwidth=4 shiftround smarttab")
vim.cmd(":set cmdheight=2 ")


vim.g.mapleader = ","

vim.api.nvim_set_keymap('n', '<leader>f', ':FZF <CR>', { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers <CR>', { noremap = true})

vim.api.nvim_set_keymap('i', '<c-x><c-x>', 'fzf#vim#complete({\'down\': \'20%\', \'source\': \'cat ~/dotfiles/scripts/data/jbehaveAsserts\'})', { noremap = true, expr=true})
vim.api.nvim_set_keymap('i', '<c-l><c-l>', 'fzf#vim#complete({\'left\': \'40%\', \'source\': \'~/dotfiles/scripts/jiraCompletion.sh\'})', { noremap = true, expr=true})

vim.api.nvim_set_keymap('n', '<leader>ge',':Gblame<CR>', { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gs',':Git<CR>', { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gc',':Gcommit<CR>', { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gl',':Git pull<CR>', { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gh',':Git push<CR>', { noremap = true})

vim.api.nvim_set_keymap('n', '<c-h>',':TmuxNavigateLeft<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<c-j>',':TmuxNavigateDown<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<c-k>',':TmuxNavigateUp<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<c-l>',':TmuxNavigateRight<cr>', { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>cpr',':Dispatch /home/maren/dotfiles/scripts/createPr.sh<cr>', {})

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


vim.api.nvim_set_keymap('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>', {})
vim.api.nvim_set_keymap('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>', {})
vim.api.nvim_set_keymap('n','K','<cmd>lua vim.lsp.buf.hover()<CR>', {})
vim.api.nvim_set_keymap('n','gr','<cmd>lua vim.lsp.buf.references()<CR>', {})
vim.api.nvim_set_keymap('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>', {})
vim.api.nvim_set_keymap('n','<leader>gt','<cmd>lua vim.lsp.buf.type_definition()<CR>', {})
vim.api.nvim_set_keymap('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>', {})
vim.api.nvim_set_keymap('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', {})
-- ACTION mappings
vim.api.nvim_set_keymap('n','<leader>ah',  '<cmd>lua vim.lsp.buf.hover()<CR>', {})
vim.api.nvim_set_keymap('n','<leader>af', '<cmd>lua require"jdtls".code_action()<CR>', {})
vim.api.nvim_set_keymap('n','<leader>ar',  '<cmd>lua vim.lsp.buf.rename()<CR>', {})
-- Few language severs support these three
vim.api.nvim_set_keymap('n','<leader>=',  '<cmd>lua vim.lsp.buf.formatting()<CR>', {})
vim.api.nvim_set_keymap('n','<leader>ai',  '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', {})
vim.api.nvim_set_keymap('n','<leader>ao',  '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', {})
-- Diagnostics mapping
vim.api.nvim_set_keymap('n','<leader>ee', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', {})
vim.api.nvim_set_keymap('n','<leader>en', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {})
vim.api.nvim_set_keymap('n','<leader>ep', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {})
vim.api.nvim_set_keymap('n', [[<leader>ai]], [[<Cmd>lua require'jdtls'.organize_imports()<CR>]], {})
vim.api.nvim_set_keymap('n', [[<leader>av]], [[<Cmd>lua require('jdtls').extract_variable()<CR>]], {})
vim.api.nvim_set_keymap('v', [[<leader>av]], [[<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>]], {})
vim.api.nvim_set_keymap('v', [[<leader>am]], [[<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]], {})
vim.api.nvim_set_keymap('n', [[<leader>aR]], [[<Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>]], {})

vim.api.nvim_set_keymap('i', '<C-Space>',[[compe#complete()]],  {noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap('i', '<CR>',[[compe#confirm('<CR>')]],  {noremap = true, silent = true, expr = true})

vim.api.nvim_set_keymap('n', '<leader>rS',':call RunMvnTest()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>rs',':call RunMvnThisTest(expand("%"))<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>jS',':call ViewSprint() <CR>', {noremap = true, silent = true}) 
vim.api.nvim_set_keymap('n', '<leader>jru',':call ViewRun() <CR> ', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>js',':call SubtaskJira(expand("<cWORD>"))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jv',':call ViewJira(expand("<cWORD>"))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jco',':call CommentJira(expand("<cWORD>"))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>je',':call EditJira(expand("<cWORD>"))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ju',':call JiraUnassign(expand("<cWORD>"))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ja',':call JiraAssign(expand("<cWORD>"))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jr',':call JiraReview(expand("<cWORD>"))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jro',':call JiraOpenReview()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jd',':call JiraDone(expand("<cWORD>"))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jp',':call JiraProgress(expand("<cWORD>"))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jt',':call JiraTodo(expand("<cWORD>"))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jl',':call SubtaskJira(g:ActualTicket)<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jm',':call MineJira()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jn',':call JiraCreateSubtask(expand("<cWORD>"))<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jpl',':call JiraPlatform()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>jo',':call JiraOpen("<cWORD>")<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>fo','gg=G\'\'', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>a',':Rg <C-r>=expand(\'<cword>\') <CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>A',':Rg <C-r>=expand(\'<CWORD>\') <CR>', {noremap = true, silent = true})


vim.api.nvim_set_keymap('n', '<leader>ds',':VimuxRunCommand "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk; mvn -Dmaven.surefire.debug  -Dtest=".expand("%:t:r")." test --offline"<CR>', {noremap = true})


vim.api.nvim_set_keymap('n', 'gx','<Plug>(openbrowser-smart-search)', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'gx','<Plug>(openbrowser-smart-search)', {noremap = true, silent = true})



