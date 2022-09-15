local path = vim.fn.getcwd()
local f=io.open(path .. "/pom.xml","r")
local testType;
if f~=nil then
  io.close(f)
  vim.cmd("let test#java#runner = 'maventest'")
  testType = "maven"
  -- return true
else
  vim.cmd("let test#java#runner = 'gradletest'")
  testType = "gradle"
end


-- wenn story file dann finde die java class

