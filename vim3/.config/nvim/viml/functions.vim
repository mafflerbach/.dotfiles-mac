function! Show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

function! Show_logs(file)
    bd! __BUILD_OUT__
    split __BUILD_OUT__
    normal! ggdG
    setlocal buftype=nofile
    :execute "silent !{bash ~/.local/bin/collection/transformTestOutput.sh ".a:file. "}"
    :r /tmp/testOutput.md
    :set ft=logs
    normal! G
endfunction

function! OpenGradleTest(file) 
    bd! __Potion_Bytecode__
    split __Potion_Bytecode__
    normal! ggdG
    setlocal buftype=logs
    :execute "silent !{bash ~/.local/bin/collection/openTestResult.sh ".a:file. "}"
    :r /tmp/buildOut
    :set ft=logs
    normal! G
endfunction

function! RunGradleTest(file) 
    bd! __Potion_Bytecode__
    split __Potion_Bytecode__
    normal! ggdG
    setlocal buftype=logs
    :execute "silent !{bash ~/.local/bin/collection/runGradleTest.sh ".a:file. "}"
    :r /tmp/gradlebuild
    :set ft=logs
    normal! G
endfunction

function! RunSQL(sql) 
    bd! __Potion_SQL__
    split __Potion_SQL__
    normal! ggdG
    setlocal buftype=nofile
    :execute "silent !{bash ~/.local/bin/collection/sqliteplus.sh ".a:sql. "}"
    :r /tmp/queryResult.csv
    normal! G
endfunction

function! RunAllGradleTest() 
    bd! __Potion_Bytecode__
    split __Potion_Bytecode__
    normal! ggdG
    setlocal buftype=logs
    :execute "silent !{ gradle jbehave 2>&1 /tmp/build }"
    :r /tmp/build
    :set ft=logs
    normal! G
endfunction



function! RunMvnTest() 
    bd! __Potion_Bytecode__
    vsplit __Potion_Bytecode__
    normal! ggdG
    setlocal buftype=logs
    if filereadable(expand("build.gradle"))
        :execute "silent !{ gradle jbehave 2>&1 |tee /tmp/gradlebuild }"
        :r /tmp/gradlebuild
    else
        :execute "silent !{export JAVA_HOME=/usr/lib/jvm/java-8-openjdk; mvn test --offline > /tmp/build}"
        :r /tmp/build
    endif

    :set ft=logs
    normal! G
endfunction


function! DecryptMessage() 
    let selection = Selection()
    :execute "!{bash ~/.local/bin/collection/decryptMessage.sh '".selection. "'}"
    let output = system("cat /tmp/decryptMessage")
    "bd! __Potion_Message__
    "split __Potion_Message__
    "normal! ggdG
    call append(line('.'), split("++++++++++++++++++++++++++", '\n'))
    call append(line('.'), split(output, '\n'))
    call append(line('.'), split(" ", '\n'))
    call append(line('.'), split(selection, '\n'))
    call append(line('.'), split("++++++++++++++++++++++++++", '\n'))

endfunction


function! RunMvnThisTest(file) 

    bd! __Potion_Bytecode__
    vsplit __Potion_Bytecode__
    normal! ggdG
    setlocal buftype=logs

    if filereadable(expand("build.gradle"))
        :execute "silent !{bash ~/.local/bin/collection/runGradleTest.sh ".a:file. "}"
        :r /tmp/buildOut
    else
        :execute "silent !{bash ~/.local/bin/collection/runTests.sh ".a:file. "}"
        :r /tmp/build
    endif
    :set ft=logs
    normal! G
endfunction


function! StopTime() 
    :execute "silent ! watson stop"
endfunction

function! StartTimeTracking(word) 
    :execute "silent ! watson start " . a:word 
endfunction

function! ViewSprint() 
    let tmpWord=expand('<cWORD>')
    split a:tmpWord
    :normal ggdG
    #:read ! jira listStories 
    :execute "read !  jira issue list --plain -q  \"sprint in openSprints() and type !=  Epic and project=INTS and type = story\" --order-by status " 
endfunction

function! ViewRun() 
    let tmpWord=expand('<cWORD>')
    split a:tmpWord
    :normal ggdG
    :read ! jira runboard 
endfunction

function! SubtaskJira(word)
    :normal ggdG
    :execute ':normal! i Parent Story ' . a:word
    #:execute "read ! jira listSubtasks " . substitute(a:word, ":", "", "")
    
    :execute "read !  jira issue list  --plain --columns assignee,summary,status -q  \"project = INTS  AND Sprint in openSprints() AND type = Sub-task and parent = a:word \" " 

# jira issue list  --plain --columns assignee,summary,status -q  \"project = INTS  AND Sprint in openSprints() AND type = Sub-task and parent = a:word \"

endfunction

function! GetGithubLink(file, line)
    let output = system("~/.local/bin/collection/getGithubLink.sh '". a:file."' '". a:line."'")
endfunction

function! GetAlternateSplit(file)
    let output = system("~/.local/bin/collection/getAlternateFile.sh '". a:file."'")
    :execute ':vsplit ' . output
endfunction

function! GetAlternate(file)
    let output = system("~/.local/bin/collection/getAlternateFile.sh '". a:file."'")
    :execute ':edit ' . output
endfunction


" jira issue move ITINFRA-16504 "Done"

function! EditJira(word)
    :call VimuxRunCommand("jira issue edit " . a:word)<CR>
    :call VimuxZoomRunner()<CR>
endfunction

function! CommentJira(word)
    :call VimuxRunCommand("jira comment " . a:word)<CR>
    :call VimuxZoomRunner()<CR>
endfunction

function! JiraDone(word) 
    :execute "silent !jira issue move " . a:word . " \"Done\"" 
    :execute     SubtaskJira(g:ActualTicket)    
endfunction

function! JiraOpenReview() 
    :normal ggdG
    :execute "read ! jira listOpenReviews " 

endfunction

function! JiraReview(word) 
    :execute 'silent !jira issue assign ' . a:word ." x"
    :execute "silent !jira issue move " . a:word . " \"In Review\"" 
    :execute SubtaskJira(g:ActualTicket)    
endfunction


function! JiraTodo(word) 
    :execute 'silent !jira transition \"Backlog\" --noedit ' . a:word 
    :execute    SubtaskJira(g:ActualTicket)    
endfunction

function! JiraProgress(word) 
    :execute 'silent !jira issue assign ' . a:word ." x"
    :execute "silent !jira transition \"In Progress\" --noedit " . a:word 
    :execute    SubtaskJira(g:ActualTicket)    
endfunction


function! JiraUnassign(word) 
    :execute 'silent !jira issue assign ' . a:word ." x"
    :execute    SubtaskJira(g:ActualTicket)    
endfunction

function! JiraAssign(word) 
    :execute 'silent !jira issue assign ' . a:word ." m9338"
    :execute    SubtaskJira(g:ActualTicket)    
endfunction

function! MineJira()
    :normal ggdG
    :execute "read ! jira mine "
endfunction

function! JiraCreateSubtask(word)
    :call VimuxRunCommand("bash ~/.local/bin/collection/createSubtask.sh " . a:word)<CR>
    :call VimuxZoomRunner()<CR>
endfunction

function JiraOpen(word)
    :execute "!qutebrowser https://jira.sixt.com/browse/" . a:word
endfunction

function! JiraPlatform()
    :normal ggdG
    :execute "read ! jira platform "
endfunction

function! ViewJira(word)
    let jiraView = system("jira view " . a:word)

    vsplit ViewTicket
    normal! ggdG
    setlocal buftype=nofile
    call append(0, split(jiraView, '\v\n'))   
    :silent %s/\r/\n/g
    :silent %s/\%x00//g
endfunction

function! Selection() abort
    try
        let a_save = @a
        silent! normal! gv"ay
        return @a
    finally
        let @a = a_save
    endtry
endfunction

function! BeautifyMvnLog() 
    let selection = Selection()
    " using jq for formatting
    let output = system("~/.local/bin/collection/parseMvnLogs.sh '". selection."'")
    call append(line('.'), split(output, '\n'))

endfunction

function! DoPrettyXML()
    " save the filetype so we can restore it later
    let l:origft = &ft
    set ft=
    " delete the xml header if it exists. This will
    " permit us to surround the document with fake tags
    " without creating invalid xml.
    1s/<?xml .*?>//e
    " insert fake tags around the entire document.
    " This will permit us to pretty-format excerpts of
    " XML that may contain multiple top-level elements.
    0put ='<PrettyXML>'
    $put ='</PrettyXML>'
    silent %!xmllint --format -
    " xmllint will insert an <?xml?> header. it's easy enough to delete
    " if you don't want it.
    " delete the fake tags
    2d
    $d
    " restore the 'normal' indentation, which is one extra level
    " too deep due to the extra tags we wrapped around the document.
    silent %<
    " back to home
    1
    " restore the filetype
    exe "set ft=" . l:origft
endfunction

fun GotoWindow(name)
    call ActivateWindowByName(a:name)
    MaximizerToggle
endfun

function! ActivateWindowByName(name)
    let l:bufid = bufnr(a:name)
    let l:winids = win_findbuf(l:bufid)
    call win_gotoid(l:winids[0])
endfunction

command! PrettyXML call DoPrettyXML()


command! A call GetAlternate(expand("%:."))
command! AS call GetAlternateSplit(expand("%:."))



