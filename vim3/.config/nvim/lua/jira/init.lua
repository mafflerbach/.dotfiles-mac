Jira = {}

local api = vim.api
local buf, win
local config = require("jira.config")
local currentIssue = ""
local action = ""

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
vim.notify = require("notify")

local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event


function Jira ()

    local self = {}

    function self.convertToTable(str)

        local t={}
        for str in string.gmatch(str, "([^\n]+)") do
            table.insert(t, str)
        end
        return t
    end

    function self.split (inputstr, sep)
        if sep == nil then
            sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
        end
        return t
    end


    local function showEdit(result, bufName, opts)
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

            -- mount/open the component
            local close = popup:map("n", "q", function(bufnr)
                popup:unmount()
            end, { noremap = true })

            local save = popup:map("n", "s", function(bufnr)
                local url = opts.url


                local content = vim.api.nvim_buf_get_lines(0, 0 ,vim.api.nvim_buf_line_count(0), false)
                local newContent =""
                for _, lines in ipairs(content) do
                    newContent = newContent..  lines
                end

                local saveurl = "cloudflared access curl \""..url.."\" --request POST --data '"..newContent.."' -H \"Content-Type: application/json\" -s"
                local handle = io.popen(saveurl)
                local result = handle:read("*a")
                handle:close()


                vim.notify(result, "info")
                vim.notify(saveurl, "info")
                popup:unmount()
            end, { noremap = true })

            popup:mount()

            -- unmount component when cursor leaves buffer
            popup:on(event.BufLeave, function()
                popup:unmount()
            end)

            -- set content
            vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, result)

        end


        local function showOutput(result, bufName)
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

                -- mount/open the component
                local close = popup:map("n", "q", function(bufnr)
                    popup:unmount()
                end, { noremap = true })

                local save = popup:map("n", "s", function(bufnr)
                    save()
                    popup:unmount()
                end, { noremap = true })

                popup:mount()

                -- unmount component when cursor leaves buffer
                popup:on(event.BufLeave, function()
                    popup:unmount()
                end)

                -- set content
                vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, result)

            end


            local function fill(str, toLength, maxlLen)
                maxlLen = maxlLen or 999
                local strLen=string.len(str)

                local difflen=toLength-strLen

                for i = 1, difflen, 1 do
                    str = str.." "
                end
                return string.sub(str,0,maxlLen)
            end

            local function fetch(url)

                local handle = io.popen("cloudflared access curl \""..url.."\" -s")
                local result = handle:read("*a")
                handle:close()

                return  result
            end


            local function postReq(url, body)
                url = "cloudflared access curl \""..url.."\" --request POST --data '"..body.."' -H \"Content-Type: application/json\" -s"
                print(url)
                local handle = io.popen(url)
                local result = handle:read("*a")
                handle:close()


                print(result)
            end

            local function putReq(url, body)

                url = "cloudflared access curl \""..url.."\" --request PUT --data '"..body.."' -H \"Content-Type: application/json\" -s";
                print(url)
                local handle = io.popen(url)
                local result = handle:read("*a")
                handle:close()


                print(result)
            end




            local function split(s, delimiter)
                local result = {};
                for match in (s..delimiter):gmatch("(.-)"..delimiter) do
                    table.insert(result, match);
                end
                return result;
            end




            local function fetchTicketJson(ticket)

                local url = config.url .. "/rest/api/2/issue/" .. ticket
                local body = fetch(url)


                local lunajson = require 'lunajson'
                local t = lunajson.decode(body)

                local issuType = t.fields.issuetype.name
                local summary = t.fields.summary
                local description = t.fields.description or ""
                local creatorName = t.fields.creator.displayName
                local status = t.fields.status.statusCategory.name
                local prio = t.fields.priority.name
                local assignee = t.fields.assignee.name

                local outputTab={}

                table.insert(outputTab, "{")
                table.insert(outputTab,'  "fields": {')
                table.insert(outputTab,'    "priority": {')
                table.insert(outputTab,'      "name": "'..prio..'"')
                table.insert(outputTab,'    },')
                table.insert(outputTab,'    "assignee": {')
                table.insert(outputTab,'      "name": "'..assignee..'"')
                table.insert(outputTab,'    },')
                table.insert(outputTab,'    "summary": "'..summary..'",')
                table.insert(outputTab,'    "description": "'..description..'"')
                table.insert(outputTab,'  }')
                table.insert(outputTab,'} ')


                return outputTab

            end



            local function fetchTicketResult(ticket)

                local url = config.url .. "/rest/api/2/issue/" .. ticket
                local body = fetch(url)

                local lunajson = require 'lunajson'


                local status, t = pcall(lunajson.decode, body)

                if not status and not t.fields then
                    print("Error loading JSON")
                    print("Current response:")
                    print(body)
                    return
                end

                local issuType = t.fields.issuetype.name
                local summary = t.fields.summary
                local description = t.fields.description
                local creatorName = t.fields.creator.displayName


                local outputTab={}
                table.insert(outputTab,issuType)
                table.insert(outputTab,"SUMMERY: " .. summary)
                table.insert(outputTab,"CREATOR: " .. creatorName)
                table.insert(outputTab,"")

                if description then
                    local splitDescription = split(description, "\n")
                    for index, value in ipairs(splitDescription) do
                        local output=""
                        output =output.. " " .. value
                        table.insert(outputTab, output)

                    end
                end

                table.insert(outputTab, "")
                table.insert(outputTab,"SUBTASKS:")

                for index, value in ipairs(t.fields.subtasks) do
                    local output=""

                    output =output.. " " .. fill(value.key, 10)
                    output =output.. " " .. fill(value.fields.status.name, 20)
                    output =output.. " " .. value.fields.summary
                    table.insert(outputTab, output)
                end

                return outputTab

            end

            local function fetchSearchResult(url)
                local body = fetch(url)
                local lunajson = require 'lunajson'
                local t = lunajson.decode(body)
                local maxLenAssigneeName=0
                local maxLenCreatorName=0
                local maxLenStatus=0
                local maxLenKey=0
                local maxLenSummary=0

                for index, value in ipairs(t.issues) do
                    local assignee=value.fields.assignee;
                    local assigneeName="XXX"
                    if assignee then
                        assigneeName = assignee.displayName
                    end

                    local assigneeNameLen=string.len(assigneeName)
                    if maxLenAssigneeName < assigneeNameLen then
                        maxLenAssigneeName = assigneeNameLen
                    end

                    local creatorNameLen= string.len(value.fields.creator.displayName)
                    if maxLenCreatorName < creatorNameLen then
                        maxLenCreatorName = creatorNameLen
                    end

                    local keyLen=string.len(value.key)
                    if maxLenKey < keyLen then
                        maxLenKey = keyLen
                    end

                    local statusLen=string.len(value.fields.status.statusCategory.name)
                    if maxLenStatus < statusLen then
                        maxLenStatus = statusLen
                    end

                    local summaryLen = string.len(value.fields.summary)
                    if maxLenSummary < summaryLen then
                        maxLenSummary = summaryLen
                    end
                end

                local header = fill("KEY", maxLenKey) .." | ".. fill("STATUS", maxLenStatus).." | ".. fill("CREATOR", maxLenCreatorName, 15) .. " | ".. fill("ASSIGNEE", maxLenAssigneeName, 15) .. " | ".. fill("SUMMARY", maxLenSummary, 80)


                local outputTab={header}
                for index, value in ipairs(t.issues) do
                    local output=""

                    output = fill(value.key,maxLenKey)
                    output = output .." | ".. fill(value.fields.status.name, maxLenStatus)
                    output = output .." | ".. fill(value.fields.creator.displayName, maxLenCreatorName, 15)

                    local assignee=value.fields.assignee;
                    local assigneeName="XXX"
                    if assignee  then
                        assigneeName = assignee.displayName
                    end
                    output = output .." | ".. fill(assigneeName, maxLenAssigneeName, 15)

                    output = output .." | ".. fill(value.fields.summary, maxLenSummary, 80 )
                    table.insert(outputTab, output)


                end

                return outputTab

            end


            local function showQuery(query, placeHolder)

                placeHolder = placeHolder or ""
                local url =config.url..config.search..config.queries[query]
                url = string.gsub(url, "REPLACE", placeHolder )
                showOutput(fetchSearchResult(url), query)
            end

            local function showIssue(issue)
                currentIssue = issue
                showOutput(fetchTicketResult(issue), issue)
            end

            local function unassign(issue)

                currentIssue = issue
                local body = "{\"fields\": {\"assignee\":{\"name\":\"\"}}}"
                local url = config.url .. "/rest/api/2/issue/" .. issue

                putReq(url, body);
            end

            local function assign(issue)

                currentIssue = issue
                local body = "{\"fields\": {\"assignee\":{\"name\":\"m9338\"}}}"
                local url = config.url .. "/rest/api/2/issue/" .. issue
                print("assigning ".. issue)
                putReq(url, body);

            end

            function save()
                local content = vim.api.nvim_buf_get_lines(0, 0 ,vim.api.nvim_buf_line_count(0), false)
                local lines =""
                local newContent =""
                for _, lines in ipairs(content) do
                    newContent = newContent..  lines
                end
                local lunajson = require 'lunajson'

                print(vim.inspect(action))
                print(vim.inspect(action))
                if action == "create" then
                    local url = config.url .. "/rest/api/2/issue/" .. currentIssue
                    postReq(url, newContent)
                elseif action == "edit" then
                    local url = config.url .. "/rest/api/2/issue/" .. currentIssue
                    putReq(url, newContent)
                else
                    local url = config.url .. "/rest/api/2/issue/" .. currentIssue .. "/comment"
                    postReq(url, newContent)
                end

                --    print(lunajson.encode(newContent))

            end

            local function done(issue)
                currentIssue = issue

                local transitionId =config.transitions["Done"]
                local body = '{"transition":{"id":"'..transitionId..'"}}'
                local url = config.url .. "/rest/api/2/issue/" .. issue .. "/transitions"

                postReq(url, body);
            end
            local function progress(issue)

                currentIssue = issue

                local transitionId =config.transitions["In Progress"]
                local body = '{"transition":{"id":"'..transitionId..'"}}'
                local url = config.url .. "/rest/api/2/issue/" .. issue .. "/transitions"

                postReq(url, body);
            end


            local function todo(issue)

                currentIssue = issue
                local transitionId =config.transitions["Icebox"]
                local body = '{"transition":{"id":'..transitionId..'}}'
                local url = config.url .. "/rest/api/2/issue/" .. issue .. "/transitions"

                postReq(url, body);
            end
            local function review(issue)

                currentIssue = issue
                local transitionId =config.transitions["In Review"]
                local body = '{"transition":{"id":'..transitionId..'}}'
                local url = config.url .. "/rest/api/2/issue/" .. issue .. "/transitions"

                postReq(url, body);
            end

            local function comment(issue)
                action = "comment"
                local content = '{"body": "EDIT ME"}'
                currentIssue = issue
                local t={}

                table.insert(t,  '{"body": "EDIT ME"}')
                showOutput(t, issue)


                -- postReq(url, body);
            end

            local function edit(issue)
                currentIssue = issue
                action = "edit"
                local currentContent = fetchTicketJson(issue)

                showOutput(currentContent, issue)
            end


            function self.getProjectId()
                local cmd = "cloudflared access curl https://jira.sixt.com/rest/api/2/project -s | jq '.[] | \"\\(.key),\\(.id)\" ' | sed 's/\\\"//g' "
                local handle = io.popen(cmd)
                local result = handle:read("*a")
                handle:close()


                local t= self.convertToTable(result)

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


                                local selection = action_state.get_selected_entry()
                                local splitresult = self.split(selection[1], ",")

                                local cmd2 = "cloudflared access curl https://jira.sixt.com/rest/api/2/issue/createmeta/"..splitresult[2].."/issuetypes -s | jq '.values[] | \"\\(.name),\\(.id)\" ' | sed 's/\\\"//g' "

                                local handle = io.popen(cmd2)
                                local result2 = handle:read("*a")
                                handle:close()
                                --          
                                ContextSelect2(opts, splitresult[2], self.convertToTable(result2))
                                print(vim.inspect(result2))
                                print(vim.inspect(result2))
                                -- http://localhost:8080/rest/api/2/issue/createmeta/{projectIdOrKey}/issuetypes/{issueTypeId}







                            end)
                            return true
                        end,
                    }):find()
                end
                ContextSelect2 = function(opts, projectKey, tableResult )
                    opts = opts or {}
                    pickers.new(opts, {
                        prompt_title = "kubectl Action",
                        finder = finders.new_table {
                            results = tableResult
                        },
                        sorter = conf.generic_sorter(opts),

                        attach_mappings = function(prompt_bufnr, map)
                            actions.select_default:replace(function()
                                actions.close(prompt_bufnr)


                                local selection2 = action_state.get_selected_entry()
                                local splitresult2 = self.split(selection2[1], ",")

                                local url = "https://jira.sixt.com/rest/api/2/issue"


                                local outputTab={}
                                table.insert(outputTab, "{")
                                table.insert(outputTab,'  "fields": {')

                                table.insert(outputTab,'    "project": {')
                                table.insert(outputTab,'        "id" : "'..projectKey..'" ')
                                table.insert(outputTab,'     },')

                                table.insert(outputTab,'    "issueType": {')
                                table.insert(outputTab,'        "id" : "'..splitresult2[2]..'" ')
                                table.insert(outputTab,'     },')


                                table.insert(outputTab,'    "customfield_12300": {')
                                table.insert(outputTab,'        "value": "Major",')
                                table.insert(outputTab,'        "value": "Significant",')
                                table.insert(outputTab,'        "value": "Minor",')
                                table.insert(outputTab,'        "value": "N/A"')
                                table.insert(outputTab,'     },')

                                table.insert(outputTab,'    "customfield_12600": {')
                                table.insert(outputTab,'        "value": "Yes",')
                                table.insert(outputTab,'        "value": "No",')
                                table.insert(outputTab,'     },')


                                table.insert(outputTab,'    "summary": "CHANGE SUMMARY", ')
                                table.insert(outputTab,'    "description": "CHANGE DESC"')
                                table.insert(outputTab,'  }')
                                table.insert(outputTab,'} ')


                                action = "create"
                                showEdit(outputTab, "CREATE", { url = url} )
                                --
                                --postReq(url, body)
                                --local handle = io.popen(cmd2)
                                --local result2 = handle:read("*a")
                                --handle:close()
                                --           
                                -- http://localhost:8080/rest/api/2/issue/createmeta/{projectIdOrKey}/issuetypes/{issueTypeId}

                            end)
                            return true
                        end,
                    }):find()
                end

                contextSelect()


            end


            local function create()
                self.getProjectId()
            end



            return {
                edit = edit,
                create = create,
                comment = comment,
                review = review,
                todo = todo,
                progress = progress,
                done= done,
                assign= assign,
                unassign = unassign,
                showQuery= showQuery,
                showIssue = showIssue
            }

        end





