Jbehave = {}

local api = vim.api

local function getClassFile()
    local currentBuffer = api.nvim_buf_get_name(0)
    local currentWorkingDir = vim.fn.getcwd()
    local relativeFilepath = string.gsub(currentBuffer, currentWorkingDir, "")

    relativeFilepath = relativeFilepath:gsub("src/test/stories/", "")
    relativeFilepath = relativeFilepath:gsub(".story", "")
    relativeFilepath = relativeFilepath:gsub("/", ".")
    return relativeFilepath
end

function Jbehave.debugStory()
    vim.cmd("VimuxRunCommand(\"mvn test -Dtest=".. getClassFile() .. " -Dmaven.surefire.debug\")")
end
function Jbehave.runStory()
    vim.cmd("VimuxRunCommand(\"mvn test -Dtest=".. getClassFile() .. "\")")
end



