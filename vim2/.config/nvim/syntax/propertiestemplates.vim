" Vim syntax file
" Language:         JBehave Story Syntax
" Maintainer:       Michael Brailsford

" Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" syn keyword tableHeader reqUrl reqMethod respBody respStatusCode respContentType reqBody times contentType headers

syn match pipes "\|"
syn match   reference           ".*="

hi link reference String  

