" Vim syntax file
" Language:         JBehave Story Syntax
" Maintainer:       Michael Brailsford

" Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn keyword gwt Given When Then Meta Narrative Scenario And Before Lifecycle Scope After
syn keyword tableHeader reqUrl reqMethod respBody respStatusCode respContentType reqBody times contentType headers
syn match gwt "^\s*And"

syn match pipes "\|"
syn match   reference           "data.*.json"
syn match   reference           "data.*.ok"
syn match   reference           "data.*.csv"
"syn match   reference           "queue"
"syn match   reference           "topic"
syn match   reference           "${DATA_DIR}.*.ok\s"
syn match   reference           "${DATA_DIR}.*.csv\s"
syn match   reference           "${DATA_DIR}.*.json\s"

syn match   topic           "Topic [a-zA-Z0-9-.]*"
syn match   queues           "virtual queue [a-zA-Z0-9-.]*"
syn match   scenario           "(?s)(?<=Scenario:)(.*?)(?=Given)"


hi link topic Structure
hi link queues Structure
hi link scenario DiffText

hi link pipes Operator
hi link reference String  
hi link queues Question  

hi link tableHeader DiffText
hi link gwt Identifier
