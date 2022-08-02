
Jira = {}


local api = vim.api
local buf, win
local config = require("jira.config")

local function showOutput(result)

  -- with small indentation results will look better

  for k,v in pairs(result) do
    result[k] = '  '..result[k]
  end
  local buf = api.nvim_create_buf(false, true)

  api.nvim_buf_set_lines(buf, 0, 0, false, result)
  api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")

  -- calculate our floating window size
  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)

  -- and its starting position
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)
  local border_opts = {
    style = "minimal",
    relative = "editor",
    width = win_width + 2,
    height = win_height + 2,
    row = row - 1,
    col = col - 1
  }
  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }
  local border_buf = api.nvim_create_buf(false, true)

  local border_lines = { '╔' .. string.rep('═', win_width) .. '╗' }
  local middle_line = '║' .. string.rep(' ', win_width) .. '║'
  for i=1, win_height do
    table.insert(border_lines, middle_line)
  end
  table.insert(border_lines, '╚' .. string.rep('═', win_width) .. '╝')

  api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

  local border_win = api.nvim_open_win(border_buf, true, border_opts)
  win = api.nvim_open_win(buf, true, opts)
  api.nvim_command('au BufWipeout <buffer> exe "silent bwipeout! "'..border_buf)
end

local function size(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
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
  local http_req = require "http.request"

  local r = http_req.new_from_uri(url)
  r.headers:upsert("authorization", "Bearer " .. config.auth)
  r.headers:upsert("accept", "*/*")
  local headers, stream = r:go()

  return  stream:get_body_as_string()


end

local function split(s, delimiter)
  result = {};
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(result, match);
  end
  return result;
end

local function fetchTicketResult(ticket)

  local url = config.url .. "/rest/api/2/issue/" .. ticket
  local body = fetch(url)

  local lunajson = require 'lunajson'
  local t = lunajson.decode(body)

  local issuType = t.fields.issuetype.name
  local summary = t.fields.summary
  local description = t.fields.description
  local creatorName = t.fields.creator.displayName

  local outputTab={}

  outputTab[1] = issuType
  outputTab[2] = "SUMMERY: " .. summary
  outputTab[3] = "CREATOR: " .. creatorName
  outputTab[4] = ""

  local splitDescription = split(description, "\n")


  for index, value in ipairs(splitDescription) do
    local newI = index + 4
    local output=""
    output =output.. " " .. value

    outputTab[newI]=output

  end

  local csize = size(outputTab)
  local empl= csize+1
  local empl2= csize+2
  outputTab[empl]=""
  outputTab[empl2]="SUBTASKS:"

  csize = size(outputTab)
  for index, value in ipairs(t.fields.subtasks) do
    local newI = index + csize
    local output=""

    output =output.. " " .. fill(value.key, 10)
    output =output.. " " .. fill(value.fields.status.name, 20)
    output =output.. " " .. value.fields.summary

    outputTab[newI]=output

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
    if assignee ~= nil then
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
    local newI = index + 1
    local output=""

    output = fill(value.key,maxLenKey)
    output = output .." | ".. fill(value.fields.status.statusCategory.name, maxLenStatus)
    output = output .." | ".. fill(value.fields.creator.displayName, maxLenCreatorName, 15)

    local assignee=value.fields.assignee;
    local assigneeName="XXX"
    if assignee ~= nil then
      assigneeName = assignee.displayName
    end
    output = output .." | ".. fill(assigneeName, maxLenAssigneeName, 15)

    output = output .." | ".. fill(value.fields.summary, maxLenSummary, 80 )
    outputTab[newI]=output


  end

  return outputTab

end

function Jira.showQuery(query, placeHolder)

  placeHolder = placeHolder or ""
  local url =config.url..config.search..config.queries[query]
  url = string.gsub(url, "REPLACE", placeHolder )
  showOutput(fetchSearchResult(url))
end

function Jira.showIssue(issue)
  showOutput(fetchTicketResult(issue))
end

-- Jira.listOutput(Jira.listSubtasks())

