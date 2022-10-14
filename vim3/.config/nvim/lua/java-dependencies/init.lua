local action_state = require "telescope.actions.state"

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"

local actions = require "telescope.actions"
local conf = require("telescope.config").values

require("java-dependencies.utils")

function JavaDependencies()
    self = {}


    function self.buildDependencyCache()

        local builder= getBuildTool()
        local cmd=''


        local f=io.open(cachePath()..'dependencies' ,"r")
        local cacheExist;
        if f~=nil then
            io.close(f)
            cacheExist = true
        else
            cacheExist = false
        end


        if not cacheExist then
            if builder == 'maven' then
                cmd='mvn dependency:list -DoutputFile='..cachePath()..'dependencies'
            elseif builder == 'gradle' then
                cmd='./gradlew dependencies 2>&1 > '..cachePath()..'dependencies'
            end
        end


        if cmd ~= '' then
            local handle = io.popen(cmd)
            local result = handle:read("*a")
            handle:close()
        end

    end

    local function deleteCache()
       os.remove(cachePath()..'dependencies')
    end

    local function listDependencies()

        self.buildDependencyCache()

        local builder= getBuildTool()

        if builder == 'maven' then

            local t = getDependencyCacheAsTable()
            fuzzyPicker(t, function()
                local selection = action_state.get_selected_entry()

                local mvnOut= parseMvnOutput(selection)
                local t2 = getClassListAsTable(mvnOut.path, mvnOut.jar)
                fuzzyPicker(t2, function()
                    local classFile = action_state.get_selected_entry()
                    NewBuffer(getClassContentTable(mvnOut.path, mvnOut.jar, classFile[1]))
                end)
            end)

        elseif builder == 'gradle' then
            -- the fucked up gradle output 
            local t = getDependencyCacheAsTable()
            fuzzyPicker(t, function()
                local selection = action_state.get_selected_entry()

                local gradleOut= parseGradleOutput(selection)

                local t2 = {}
                if gradleOut ~= nil then
                    print(gradleOut.path)
                    print(gradleOut.jar)
                    t2 = getClassListAsTable(gradleOut.path, gradleOut.jar)
                    fuzzyPicker(t2, function()
                        local classFile = action_state.get_selected_entry()
                        if classFile ~= "" then
                            NewBuffer(getClassContentTable(gradleOut.path, gradleOut.jar, classFile[1]))
                        end
                    end)
                else
                    vim.notify("NO JARS FOUND", "info")
                end
            end)
        end
    end


    return {
        listDependencies=listDependencies,
        deleteCache=deleteCache
    }

end




