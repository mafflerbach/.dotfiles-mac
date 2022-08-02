local path = vim.fn.getcwd()
local f=io.open(path .. "/pom.xml","r")

if f~=nil then
  io.close(f)
  vim.cmd("let test#java#runner = 'maventest'")
  -- return true
else
  vim.cmd("let test#java#runner = 'gradletest'")
end
