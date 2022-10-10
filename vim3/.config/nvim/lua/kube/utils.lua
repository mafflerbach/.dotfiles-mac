
local action_state = require "telescope.actions.state"

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"

local config = require("kube.config")
local actions = require "telescope.actions"
local conf = require("telescope.config").values

local namespaceParam = function()
    local namespace = ""
    if config.namespace ~= "" then
        namespace ="-n " .. config.namespace
    end

    return namespace
end


function cmdResultAsTable(cmd)
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()

    return convertToTable(result)

end

function getServiceName(pod)
            pod = string.gsub(pod, "pod/", "")

            pod = string.reverse(pod)
            local t2={}
            for str in string.gmatch(pod, "([^-]+)") do
                table.insert(t2, str)
            end
            table.remove(t2, 1)
            table.remove(t2, 1)

            local service = table.concat(t2, "-")
            return  string.reverse(service)

end


function convertToTable(str)

    local t={}
    for str in string.gmatch(str, "([^\n]+)") do
        table.insert(t, str)
    end
    return t
end

function getPodList()
    local cmd = 'kubectl get pods '..namespaceParam()..' -o name'
    return cmdResultAsTable(cmd)
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

function NewBuffer(table)

    vim.cmd('vsplit')
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(win, buf)

    vim.api.nvim_put(table , "", false, true)
end

