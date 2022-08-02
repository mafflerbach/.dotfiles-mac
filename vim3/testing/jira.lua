
Jira = {}

function Jira.listRunBoard()
  local url='https://jira.sixt.com/rest/api/2/search?jql=project+=+INTS++AND+Sprint+in+openSprints()+AND+type+=+Sub-task+and+parent+=+INTS-6069+ORDER+BY+status+DESC&startAt=0&maxResults=100'

  --
  -- importing HTTP package
  local lua_http_variable= require("lua-http");
  -- specifying headers
  local headers = {}
  headers["Authorization"] = "Bearer MjQ0MDQ5MTY0MjM5On2bnmjuThyuhGE/6Mr8QRM2bmuF"

  -- making HTTP call
  response, err = lua_http_variable.request("GET", url, {
    headers={
      headers
    }
  })
  if err then error(err) end

  -- parsing response body from the API
  -- Single-shot requests use the `request_uri` interface.


  print(response.body)
end

function Jira.listSubtasks()
  local url='https://jira.sixt.com/rest/api/2/search?jql=project+=+INTS++AND+Sprint+in+openSprints()+AND+type+=+Sub-task+and+parent+=+INTS-6069+ORDER+BY+status+DESC&startAt=0&maxResults=100'
  -- Jira.listRunBoard()


  local http_req = require "http.request"
  local r = http_req.new_from_uri(url)
  r.headers:upsert("authorization", "Bearer MjQ0MDQ5MTY0MjM5On2bnmjuThyuhGE/6Mr8QRM2bmuF")
  r.headers:upsert("accept", "*/*")
  local headers, stream = r:go()

  local body = stream:get_body_as_string()

  local lunajson = require 'lunajson'

  local t = lunajson.decode(body)
  local output=""
  local outputTab={"KEY","STATUS","CREATOR","ASSIGNEE","SUMMARY"}
  for index, value in ipairs(t.issues) do

    output = output .. value.key
    output = output .."\t".. value.fields.status.statusCategory.name
    output = output .."\t".. value.fields.creator.displayName
    local assignee=value.fields.assignee;
    if assignee == nil then
      output = output .."\t".. "XX"
    else
      output = output .."\t".. assignee.displayName
    end

    output = output .."\t"..value.fields.summary 
    outputTab[index]=output
  end

  return outputTab
end


