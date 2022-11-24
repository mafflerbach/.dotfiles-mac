local _M = {}

_M.url = "https://jira.sixt.com"
_M.search = "/rest/api/2/search?jql="
_M.transitions = {
    ["Blocked"]                   = 311,
    ["Icebox"]                    = 321,
    ["Backlog"]                   = 331,
    ["In Progress"]               = 341,
    ["In Review"]                 = 351,
    ["Requirement Specification"] = 361,
    ["Estimation"]                = 371,
    ["Cancelled"]                 = 381,
    ["Done"]                      = 391,
    ["On Hold"]                   = 401,

}

_M.queries = {
    ["showCurrentRunBoard"] = "project+=+INTS+AND+type+=+Task+and+(status+=+Icebox+or+status+=+Backlog+or+status+=+%22In+Progress%22+or+status+=+%22Blocked%22+or+status+=+%22In+Review%22+or+status+=+%22On+Hold%22)+ORDER+BY+status+DESC&startAt=0&maxResults=100",
    ["showCurrentSprint"] = "sprint+in+openSprints()+and+type+!=++Epic+and+project=INTS+and+type+=+story+ORDER+BY+status+DESC&startAt=0&maxResults=100",
    ["showMigrationSprint"] = "sprint+in+openSprints()+and+type!=Epic+and+project=INTS+and+status+!=+done+ORDER+BY+status+DESC",
    ["showSubtask"] = "project+=+INTS++AND+Sprint+in+openSprints()+AND+type+=+Sub-task+and+REPLACE+ORDER+BY+status+DESC&startAt=0&maxResults=100"
}


local function getCurl ()

    local function getCookie()

        local cookie

        local inputHar = vim.env.XDG_CONFIG_HOME .. '/nvim/lua/jira/har.input.json'
        local handle = io.popen("jq '[(.log.entries[].request.headers[] | select(.name==\"cookie\")).value][0]' < " ..  inputHar)
        local result = handle:read("*a")
        handle:close()

        cookie = string.gsub(result, '\"', "")
        cookie = string.gsub(cookie, '\n', "")

        return cookie
    end

    local cookie = getCookie()

    return '-H \'cookie: '.. cookie..'\''
end
_M.curl = getCurl()



return _M


--lua Jira.showQuery("showSubtask", "parent+=+INTS-6069" )
--lua Jira.showQuery("showCurrentRunBoard")
--lua Jira.showQuery("showMigrationSprint")
--lua Jira.showQuery("showCurrentSprint")
--
--
--
--lua Jira.showIssue("INTS-6069")
