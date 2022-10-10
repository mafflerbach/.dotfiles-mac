local path = vim.fn.getcwd()
local f=io.open(path .. "/pom.xml","r")
local testType;
local opts = { noremap=true, silent=true }
if f~=nil then
  io.close(f)
  vim.cmd("let test#java#runner = 'maventest'")
  vim.cmd("let test#runner_commands =['Maven']")
  testType = "maven"
  -- return true

vim.api.nvim_set_keymap('n', '<leader>rS',':call RunMvnTest()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>rs',':call RunMvnThisTest(expand("%:."))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ds',':VimuxRunCommand "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk; mvn -Dmaven.surefire.debug  -Dtest=".expand("%:t:r")." test --offline"<CR>', {noremap = true})

else
  vim.cmd("let test#java#runner = 'gradletest'")
  testType = "gradle"

vim.api.nvim_set_keymap('n', '<leader>rs',':TestFile<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>dt',':TestFile --debug-jvm<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>dnm,',':TestNearest --debug-jvm<CR>', {noremap = true})


end


-- wenn story file dann finde die java class

