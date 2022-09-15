" Vim syntax file
" Language:         JBehave Story Syntax
" Maintainer:       Michael Brailsford

" Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

  syntax clear
syn keyword gwt Given When Then Meta Narrative Scenario And Before Lifecycle Scope After
syn keyword tableHeader reqUrl reqMethod respBody respStatusCode respContentType reqBody times contentType headers
syn match gwt "^\s*And"

syn match pipes "|"
syn match   reference           "data.*.json"
syn match   reference           "data.*.ok"
syn match   reference           "data.*.csv"
"syn match   reference           "queue"
"syn match   reference           "topic"
syn match   reference           "${DATA_DIR}.*.ok\s"
syn match   reference           "${DATA_DIR}.*.csv\s"
syn match   reference           "${DATA_DIR}.*.json\s"
syn match   reference           "file:\/\/[a-za-z0-9-\/_]*.[a-z]*"
syn match   reference           "resources\/[a-za-z0-9-\/_]*.[a-z]*"
syn match   reference           "resources\/[a-za-z0-9-\/_]*.[a-z]*"

syn match   topic           "[tT]opic [a-za-z0-9-.]*"
syn match   queues           "virtual queue [a-zA-Z0-9-.]*"
syn match   queue           "[Qq]ueue [a-zA-Z0-9-.]*"
syn match   target           "to [a-zA-Z0-9-.]*"
syn match   scenario           "(?s)(?<=Scenario:)(.*?)(?=Given)"


hi link topic Structure
hi link target String
hi link queues Structure
hi link queue Structure
hi link scenario DiffText

hi link pipes Operator
hi link reference String  
hi link queues Question  

hi link tableHeader DiffText
hi link gwt Identifier
