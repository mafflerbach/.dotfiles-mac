local _M = {}

_M.url = "https://jira.sixt.com"
_M.search = "/rest/api/2/search?jql="
_M.auth =  ""

_M.queries = {
  ["showCurrentRunBoard"] = "project+=+INTS+AND+type+=+Task+and+(status+=+Icebox+or+status+=+Backlog+or+status+=+%22In+Progress%22+or+status+=+%22Blocked%22+or+status+=+%22In+Review%22+or+status+=+%22On+Hold%22)+ORDER+BY+status+DESC&startAt=0&maxResults=100",

  ["showCurrentSprint"] = "sprint+in+openSprints()+and+type+!=++Epic+and+project=INTS+and+type+=+story+ORDER+BY+status+DESC&startAt=0&maxResults=100",

  ["showSubtask"] = "project+=+INTS++AND+Sprint+in+openSprints()+AND+type+=+Sub-task+and+REPLACE+ORDER+BY+status+DESC&startAt=0&maxResults=100"
}


return _M


--lua Jira.showQuery("showSubtask", "parent+=+INTS-6069" )
--lua Jira.showQuery("showCurrentRunBoard")
--lua Jira.showQuery("showCurrentSprint")
--lua Jira.showIssue("INTS-6069")
