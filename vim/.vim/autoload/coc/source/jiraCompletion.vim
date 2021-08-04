" vim source for emails
" recomend using a filelists 
function! coc#source#jiraCompletion#init() abort
  return {
        \ 'priority': 9,
        \ 'triggerCharacters': ['INTS'],
        \ 'filetypes': ['markdown','gitcommit', 'yaml' ],
        \ 'shortcut': 'JIRA'
        \}
endfunction

function! coc#source#jiraCompletion#complete(opt, cb) abort
""  let items = systemlist('jira list ')
  let items = systemlist('jira listSubtasksMyStory '. g:ActualTicket)
  call a:cb(items)
endfunction


