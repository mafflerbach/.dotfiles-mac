local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
vim.notify = require("notify")

local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

function Kube ()

    selector = function (cmd , cmd2, buffer, cb)
        local bufferFlag = buffer or false
        local callback = cb or false


        local handle = io.popen(cmd)
        local result = handle:read("*a")
        handle:close()

        --print(result)
        local t={}
        for str in string.gmatch(result, "([^\n]+)") do
            table.insert(t, str)
        end


        local contextSelect = function(opts)
            opts = opts or {}
            pickers.new(opts, {
                prompt_title = "kubectl Action",
                finder = finders.new_table {
                    results = t
                },
                sorter = conf.generic_sorter(opts),

                attach_mappings = function(prompt_bufnr, map)
                    actions.select_default:replace(function()
                        actions.close(prompt_bufnr)

                        if not callback then

                            local selection = action_state.get_selected_entry()
                            local handle = io.popen(cmd2 .. " " .. string.gsub(selection[1], "pod/", ""))
                            local result2 = handle:read("*a")
                            handle:close()
                            if bufferFlag then

                                local win= vim.api.nvim_get_current_win()
                                local buf = vim.api.nvim_create_buf(false, true)
                                vim.api.nvim_win_set_buf(win,buf)

                                local t2={}
                                for str in string.gmatch(result2, "([^\n]+)") do
                                    table.insert(t2, str)
                                end
                                vim.api.nvim_put(t2 , "", false, true)
                            else
                                vim.notify(result2, "info")
                            end
                        else
                            local selection = action_state.get_selected_entry()
                            callback(selection)
                        end


                    end)
                    return true
                end,
            }):find()
        end

        -- to execute the function
        contextSelect()

    end
    local pods = function ()
        local cmd = 'kubectl get pods -n it-integration -o name'
        local handle = io.popen(cmd)
        local result = handle:read("*a")
        handle:close()

        local t={}
        for str in string.gmatch(result, "([^\n]+)") do
            table.insert(t, str)
        end

        local popup = Popup({
            enter = true,
            focusable = true,
            border = {
                style = "rounded",
            },
            text = {

                top_align = "center",
                top = "Pod list"
            },
                position = "15%",
                size = {
                    width = "90%",
                    height = "60%",
                },
            })

            -- mount/open the component
            popup:mount()

            -- unmount component when cursor leaves buffer
            popup:on(event.BufLeave, function()
                popup:unmount()
            end)

            -- set content
            vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, t)

        end

        local restart = function ()
            local cmd = 'kubectl get pods -n it-integration -o name'
            local cmd2 = "kubectl delete  pod -n it-integration "
            selector(cmd, cmd2)
        end

        local describePod = function  ()
            local cmd = 'kubectl get pods -n it-integration -o name'
            local cmd2 = "kubectl describe pod  -n it-integration "

            selector(cmd, cmd2, true)
        end
        local context = function ()
            local cmd = 'kubectl config get-contexts -o name'
            local cmd2 = 'kubectl config use-context '
            selector(cmd, cmd2)
        end

        local logs = function ()
            local cmd = 'kubectl get pods -n it-integration -o name'
            local cmd2 = 'kubectl logs -n it-integration '
            selector(cmd, cmd2, true)
        end

        local undeploy = function ()
            local cmd = 'kubectl get pods -n it-integration -o name'
            local cmd2 = ''
            selector(cmd, cmd2, false, function(selection)

                local pod = string.gsub(selection[1], "pod/", "")
                pod = string.reverse(pod)

                local t={}
                for str in string.gmatch(pod, "([^-]+)") do
                    table.insert(t, str)
                end
                table.remove(t, 1)
                table.remove(t, 1)

                local service = table.concat(t, "-")
                service = string.reverse(service)

                local cmd2 = "kubectl delete deployment -n it-integration " .. service
                local handle = io.popen(cmd2)
                local result2 = handle:read("*a")
                handle:close()

                vim.notify(result2, "info")

            end)
        end

        return {
            context = context,
            logs = logs,
            describePod = describePod,
            restart = restart,
            undeploy = undeploy,
            pods = pods

        }
    end


    --function podLogin {
    --pod=$(kubectl get pods  -n it-integration| fzf); kubectl exec -it $(echo $pod | cut -f1 -d' ')  -n it-integration -- sh
    --}


    --# kubectl exec -it <pod name> -c logging -- sh

