function Kube()
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

    local config = require("kube.config")
    require("kube.utils")
    local self = {}

    local namespaceParam = function()
    local namespace = ""
    if config.namespace ~= "" then
    namespace ="-n " .. config.namespace
    end

    return namespace
    end



    function self.convertToTable(str)

        local t={}
        for str in string.gmatch(str, "([^\n]+)") do
            table.insert(t, str)
        end
        return t
    end


    function test()
        print(namespaceParam())

    end



    local pods = function ()
        local t = getPodList()


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


    local listPods = function ()

        local split = Split({
            relative = "editor",
            position = "right",
            size = "20%",
        })

        -- mount/open the component
        split:mount()

        -- unmount component when cursor leaves buffer
        --split:on(event.BufLeave, function()
        --split:unmount()
        --end)

        local t = getPodList()
        vim.api.nvim_buf_set_lines(split.bufnr, 0, 1, false, t)
        vim.api.nvim_buf_set_keymap(split.bufnr, 'n', "c", ':lua Kube()._getMenu(vim.fn.expand("<cWORD>"))' ,{})

    end



    local restart = function ()
        local cmd2 = "kubectl delete  pod "..namespaceParam().." "

        local t = getPodList()
        fuzzyPicker(t, function()
            local selection = action_state.get_selected_entry()
            local t2 = cmdResult(cmd2 .. " " .. string.gsub(selection[1], "pod/", ""))
            
            vim.notify(t2, "info")

        end)
    end


    local describePod = function (podname)
        podname =  podname or ""

        local cmd2 = "kubectl describe pod  "..namespaceParam().." "
        if podname == ""  then

            local t = getPodList()
            fuzzyPicker(t, function()
                local selection = action_state.get_selected_entry()
                local t2 = cmdResult(cmd2 .. " " .. string.gsub(selection[1], "pod/", ""))

                NewBuffer(t2)

            end)

        else

            local t2 = cmdResult(cmd2 .. " " .. string.gsub(podname, "pod/", ""))
            NewBuffer(t2)

        end

    end


    local context = function ()
        local cmd = 'kubectl config get-contexts -o name'
        local cmd2 = 'kubectl config use-context '

        local t = cmdResult(cmd)
        fuzzyPicker(t, function()
            local selection = action_state.get_selected_entry()
            local t2 = cmdResult(cmd2 .. selection[1])

            vim.notify(t2, "info")

        end)
    end


    local cppod = function ()
        local t = getPodList()
        fuzzyPicker(t, function()
            local selection = action_state.get_selected_entry()
            local pod = string.gsub(selection[1], "pod/", "")
            vim.fn.setreg("+", pod)

            vim.notify(selection[1], "info")

        end)
    end


    local config = function ()
        local t = cmdResult('kubectl get configmaps '..namespaceParam()..' -o name')

        fuzzyPicker(t, function()
            local selection = action_state.get_selected_entry()
            local configSel = string.gsub(selection[1], "configmap/", "")
            local cmd2 = "kubectl get configmaps "..namespaceParam().." " .. configSel .. " -o yaml"
            local t2 = cmdResult(cmd2)

            NewBuffer(t2)

        end)
    end

    local logs = function ()
        local t = getPodList()

        fuzzyPicker(t, function()
            local selection = action_state.get_selected_entry()
            local pod = string.gsub(selection[1], "pod/", "")
            local cmd2 = 'kubectl logs '..namespaceParam()..' ' .. pod
            local t2 = cmdResult(cmd2)

            NewBuffer(t2)

        end)
    end


    local getMenu = function (podname)
        vim.notify(podname, "info")
        local menu = Menu({
            position = "50%",
            size = {
                width = 25,
                height = 15,
            },
            border = {
                style = "single",
                text = {
                    top = "[Menue]",
                    top_align = "center",
                },
            },
            win_options = {
                winhighlight = "Normal:Normal,FloatBorder:Normal",
            },
        }, {
            lines = {
                Menu.item("Terminal", {action = 'terminal'}),
                Menu.item("Restart", {action = 'restart'}),
                Menu.item("Undeploy", {action = 'undeploy'}),
                Menu.item("Port Forward", {action = 'forward'}),
                Menu.separator("", {
                    char = "-"
                }),
                Menu.item("Describe Pod", {action = 'describePod'}),
                Menu.item("Describe Service", {action = 'describeService'}),
                Menu.item("Logs", {action = 'logs'}),
                Menu.item("Copy podname", {action = 'cppod'}),
            },
            max_width = 20,
            keymap = {
                focus_next = { "j", "<Down>", "<Tab>" },
                focus_prev = { "k", "<Up>", "<S-Tab>" },
                close = { "<Esc>", "<C-c>" },
                submit = { "<CR>", "<Space>" },
            },
            on_close = function()
                print("Menu Closed!")
            end,
            on_submit = function(item)
                print("Menu Submitted: ", item.action)
                local c_tbl =
                {
                    logs = function (podname)
                        vim.notify("choose logs" .. podname, "info")
                    end,
                    cppod = function (podname)
                        vim.notify("choose cppod " .. podname, "info")
                    end,
                    describePod = function (podname)
                        describePod(podname)
                    end,
                }

                local func = c_tbl[item.action]
                func(podname)



            end,
        })

        -- mount the component
        menu:mount()

    end


    local describeIngress = function ()
        local t = getPodList()
        fuzzyPicker(t, function()
            local selection = action_state.get_selected_entry()
            local service = getServiceName(selection[1])
            local cmd2 = "kubectl describe ingress "..namespaceParam().." " .. service
            local t3 = cmdResult(cmd2)

            NewBuffer(t3)
        end)

    end




    local describeService = function ()
        local t = getPodList()
        fuzzyPicker(t, function()
            local selection = action_state.get_selected_entry()
            local service = getServiceName(selection[1])
            local cmd2 = "kubectl describe service "..namespaceParam().." " .. service
            local t3 = cmdResult(cmd2)

            NewBuffer(t3)

        end)

    end




    local undeploy = function ()

        local t = getPodList()
        fuzzyPicker(t, function()
            local selection = action_state.get_selected_entry()
            local service = getServiceName(selection[1])
            local cmd2 = "kubectl delete deployment "..namespaceParam().." " .. service
            local t3 = cmdResult(cmd2)

            vim.notify(t3, "info")

        end)
    end

    return {
        context = context,
        logs = logs,
        describePod = describePod,
        describeIngress = describeIngress,
        describeService = describeService,
        restart = restart,
        undeploy = undeploy,
        pods = pods,
        config = config,
        cppod = cppod,
        listPods = listPods,
        _getMenu = getMenu,
    }



-- kubectl describe ingress service-generic-event-receiver
end


--function podLogin {
--pod=$(kubectl get pods  '..namespaceParam()..'| fzf); kubectl exec -it $(echo $pod | cut -f1 -d' ')  '..namespaceParam()..' -- sh
--}


--# kubectl exec -it <pod name> -c logging -- sh

