
local Menu = require("nui.menu")
local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local event = require("nui.utils.autocmd").event
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local Split = require("nui.split")

vim.notify = require("notify")

local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
function convertToTable(str)

    local t={}
    for str in string.gmatch(str, "([^\n]+)") do
        table.insert(t, str)
    end
    return t
end

function cachePath()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)") .. "cache/"
end

function script_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end
function getClassContentTable(path, jar, classFile) 
    cmd = "javap  jar:file:///home/maren/.m2/repository/"..path.."/"..jar.."!/" .. classFile
    return cmdResult(cmd)
end
function getClassListAsTable(path, jar) 
    -- print("jar tf /home/maren/.m2/repository/"..path.."/"..jar.." | grep class | fzf ")
    cmd = "jar tf /home/maren/.m2/repository/"..path.."/"..jar.." | grep class "

    return cmdResult(cmd)
end

function NewBuffer(table)

    vim.cmd('vsplit')
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(win, buf)
    vim.bo.filetype="java"
    vim.api.nvim_put(table , "", false, true)
end

function getDependencyCacheAsTable() 
    return cmdResult('cat ' .. cachePath()..'dependencies')
end

function fuzzyPicker (finderTable,  cb)
    local callback = cb or false


    local contextSelect = function(opts)
        opts = opts or {}
        pickers.new(opts, {
            finder = finders.new_table {
                results = finderTable
            },
            sorter = conf.generic_sorter(opts),

            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)

                    callback()

                end)
                return true
            end,
        }):find()
    end

    -- to execute the function
    contextSelect()

end

function cmdResult(cmd)
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()

    return convertToTable(result)

end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function split(str, delimiter)

    local t={}
    for str in string.gmatch(str, "([^"..delimiter.."]+)") do
        table.insert(t, str)
    end
    return t
end

function convertToTable(str)

    local t={}
    for str in string.gmatch(str, "([^\n]+)") do
        table.insert(t, str)
    end
    return t
end

function getBuildTool()

    local path = vim.fn.getcwd()
    local f=io.open(path .. "/pom.xml","r")
    local testType;
    if f~=nil then
        io.close(f)
        testType = "maven"
    else
        testType = "gradle"
    end

    return testType

end

-- Why Gradle... why.. 
function parseGradleOutput(selection)

    local cleanLine = string.gsub(selection[1], ".*- ", "")
    cleanLine = string.gsub(cleanLine, " %(c%)", "")
    cleanLine = string.gsub(cleanLine, " %(%*%)", "")

    local foo=split(cleanLine, ":")
    local packagePath = string.gsub(foo[1], "%.", "/")
    packagePath = string.gsub(packagePath, " ", "")
    local packageName = foo[2]
    local version = foo[3]
    local path=packagePath.."/"..packageName.."/"..version
    local jar=packageName.."-"..version..".jar"

    if string.find(path, "+") then
        local test = split(path, " ")
        local pack = split(test[1], "/")

        local count = tablelength(pack)
        table.remove(pack, count)
        local ver = string.gsub(test[3], "%.jar", "")
        path= table.concat(pack, '/').."/"..ver.."/"
    end

    if string.find(path, "->") then
        local test = split(path, " ")
        local pack = split(test[1], "/")
        local ver = string.gsub(test[3], "%.jar", "")
        local count = tablelength(pack)
        table.remove(pack, count)
        path= table.concat(pack, '/').."/"..ver.."/"
    end

    if string.find(jar, "->") then
        local test = split(jar, " ")

        local pack = split(test[1], "-")
        local count = tablelength(pack)
        local packStr
        if count >= 3 then
            table.remove(pack, count)
            packStr = table.concat(pack ,"-")
        else
            packStr = pack[1]
        end


        local ver = string.gsub(test[3], "%.jar", "")
        jar=packStr.."-"..ver..".jar"
    end


    local f=io.open("/home/maren/.m2/repository/"..path.."/"..jar, "r")
    if f~=nil then
        io.close(f)
        return {jar=jar,path=path}
    else
        local pack = split(path, "/")
        local count = tablelength(pack)
        table.remove(pack, count)
        count = tablelength(pack)
        local packName = pack[count]
        path = table.concat(pack ,"/")
        local dirContent= scandir("/home/maren/.m2/repository/".. path)

        if dirContent[1] ~=nil then
            path=path.."/"..dirContent[1]
            jar=packName.."-"..dirContent[1]..".jar"
            return {jar=jar,path=path}
        else
            return nil
        end
    end


end
function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    cmd = '/usr/bin/ls -vr1 "'..directory..'"'
    local pfile = popen(cmd)
    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end
function parseMvnOutput(selection)
    local foo=split(selection[1], ":")
    local packagePath = string.gsub(foo[1], "%.", "/")
    packagePath = string.gsub(packagePath, " ", "")
    local packageName = foo[2]
    local version = foo[4]
    local path=packagePath.."/"..packageName.."/"..version
    local jar=packageName.."-"..version..".jar"

    return {jar=jar,path=path}
end
