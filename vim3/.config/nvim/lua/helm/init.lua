
local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event


function Helm ()

    local self={}

    local function deploy()

        --helm secrets upgrade --install   service-generic-event-receiver                         \
        --service-generic-event-receiver                         \
        ----values    service-generic-event-receiver/values/stage/values.yaml  \
        ----values    service-generic-event-receiver/values/stage/secrets.yaml \
        ----namespace it-integration




    end

    local function getValues()
        popup = self.popupSkel("VALUES")


            local search = popup:map("n", "s", function()
                popup:unmount()
            end, { noremap = true })


        popup:mount()

        local command="rg \"\\{\\{ \\.Values\\..* \\}\\}\" --only-matching -I -N | sort -u "
        local handle = io.popen(command)
        local result = handle:read("*a")
        handle:close()

        vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, self.convertToTable(result))
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


        function self.convertToTable(str)

            local t={}
            for str in string.gmatch(str, "([^\n]+)") do
                table.insert(t, str)
            end
            return t
        end



        return {
            deploy = deploy,
            getValues = getValues
        }
    end
