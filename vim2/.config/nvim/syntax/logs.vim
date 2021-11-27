" Vim syntax file
" Language:         JBehave Story Syntax
" Maintainer:       Michael Brailsford

" Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn keyword gwt Given When Then Meta Narrative Scenario And 

syn keyword tableHeader reqUrl reqMethod respBody respStatusCode respContentType reqBody times contentType headers
syn keyword logs INFO WARNING ERROR 

syn match pipes "\|"

hi link pipes Operator
hi link reference String  

hi link tableHeader Define
hi link logs Comment
