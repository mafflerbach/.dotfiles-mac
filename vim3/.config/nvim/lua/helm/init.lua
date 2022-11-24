
local action_state = require "telescope.actions.state"
vim.notify = require("notify")
local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local pickers = require "telescope.pickers"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local finders = require "telescope.finders"


function Helm ()

    local self={}
    function self.fuzzyPicker(finderTable, cb)

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


    function self.getYamlFiles()
        local command='find . \\( -name "*.yml"  -o -name "*.yaml" \\)'
        local handle = io.popen(command)
        local result = handle:read("*a")
        handle:close()
        return self.convertToTable(result)

    end

    function self.convertToTable(str)

        local t={}
        for str in string.gmatch(str, "([^\n]+)") do
            table.insert(t, str)
        end
        return t
    end

    local function deploy()

        --helm secrets upgrade --install   service-generic-event-receiver                         \
        --service-generic-event-receiver                         \
        ----values    service-generic-event-receiver/values/stage/values.yaml  \
        ----values    service-generic-event-receiver/values/stage/secrets.yaml \
        ----namespace it-integration




    end

    local function getValues()

        local command="rg \"\\{\\{ \\.Values\\..* \\}\\}\" --vimgrep --only-matching | sort -u "
        local handle = io.popen(command)
        local result = handle:read("*a")
        handle:close()

        vim.notify(command, "info")
        local result2 =  self.convertToTable(result)

        local contextSelect = function(opts)
            opts = opts or {}
            pickers.new(opts, {
                finder = finders.new_table {
                    results = result2
                },
                sorter = conf.generic_sorter(opts),
            }):find()
        end

        -- to execute the function
        contextSelect()
    end



    function self.popupSkel(bufName)

        local popup = Popup({
            enter = true,
            focusable = true,
            border = {
                style = "rounded",
            },
            text = {

                top_align = "center",
                top = bufName},
                position = "15%",
                size = {
                    width = "90%",
                    height = "60%",
                },
            })
            -- unmount component when cursor leaves buffer
            popup:on(event.BufLeave, function()
                popup:unmount()
            end)

            return popup
        end


        local decrypt = function ()
            --  contect change
            --  helm secrets dec charts/service-vehicle-maintenance-refurbishment/values/prod/secrets.yaml 

            self.fuzzyPicker(self.getYamlFiles(), function()
                local selection = action_state.get_selected_entry()

                local command='helm secrets dec ' .. selection[1]
                local handle = io.popen(command)
                local result = handle:read("*a")
                handle:close()

                vim.notify(command, "info")
                vim.notify(result, "info")
            end)


        end



        local encrypt = function ()
            --  contect change
            --  helm secrets enc charts/service-vehicle-maintenance-refurbishment/values/prod/secrets.yaml 

            self.fuzzyPicker(self.getYamlFiles(), function()
                local selection = action_state.get_selected_entry()

                local command='helm secrets enc ' .. selection[1]
                local handle = io.popen(command)
                local result = handle:read("*a")
                handle:close()

                vim.notify(result, "info")

            end)


        end

        return {
            deploy = deploy,
            getValues = getValues,
            encrypt=encrypt,
            decrypt=decrypt
        }
    end
