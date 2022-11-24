local Input = require("nui.input")
local Layout = require("nui.layout")
local NuiText = require("nui.text")
local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

function Testing()

    local self = {}


    function test()
        local popup = Popup({
            enter = true,
            focusable = true,
            border = {
                style = "rounded",
            },
            text = {

                top_align = "center",
                top = "Buffer name"},
                position = "15%",
                size = {
                    width = "90%",
                    height = "60%",
                },
            })

            -- mount/open the component
            local close = popup:map("n", "q", function(bufnr)
                popup:unmount()
            end, { noremap = true })

            local save = popup:map("n", "s", function(bufnr)


                local content = vim.api.nvim_buf_get_lines(0, 0 ,vim.api.nvim_buf_line_count(0), false)
                local newContent =""
                for _, lines in ipairs(content) do
                    newContent = newContent..  lines
                end





                print(vim.inspect(content))
local foo = table.concat(content, "\n")

                print(vim.inspect(foo))
                --local saveurl = "cloudflared access curl \""..url.."\" --request POST --data '"..newContent.."' -H \"Content-Type: application/json\" -s"
                --local handle = io.popen(saveurl)
                --local result = handle:read("*a")
                --handle:close()


                popup:unmount()
            end, { noremap = true })

            popup:mount()

            -- unmount component when cursor leaves buffer
            popup:on(event.BufLeave, function()
                popup:unmount()
            end)

            -- set content
        end

        return {
            test = test
        }

    end
