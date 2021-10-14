nmap <leader>sc :set spell<CR> 
nmap <leader>!sc :set nospell<CR> 

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" strg+s for save buffer
nmap <c-s> :w <CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>
" Save the current vim session 
nmap <leader>sp :w <bar> SSave! <C-R>=$FQSN <CR><CR>

" ripgrep 
noremap <leader>a :Rg <C-r>=expand('<cword>') <CR>
noremap <leader>A :Rg <C-r>=expand('<CWORD>') <CR>

noremap <leader>cos :CocSearch <C-r>=expand('<CWORD>') <CR>

" explor files withc fuzzy search 
noremap <leader>f :FZF<CR>

command! -bang ProjectFiles call fzf#vim#files('src', {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat {}']}, <bang>0)
noremap <leader>F :ProjectFiles<CR>
inoremap <expr> <c-x><c-x> fzf#vim#complete({'down': '20%', 'source': 'cat ~/dotfiles/scripts/data/jbehaveAsserts'})
inoremap <expr> <c-l><c-l> fzf#vim#complete({'left': '37%', 'source': 'jiraCompletion.sh'})
"
" some fungitive shortings
noremap <leader>ge :Gblame<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gc :Gcommit<CR>
noremap <leader>gl :Gpull<CR>
noremap <leader>gh :Gpush<CR>

" linewiese git actions
noremap <leader>gus :SignifyHunkDiff<CR>
noremap <leader>gutu :SignifyHunkUndo<CR>
noremap <leader>gutd :SignifyDiff<CR>

" list buffers and switch to 
noremap <leader>b :Buffers<CR>

" start mvn build in debug mode
noremap <leader>ds :VimuxRunCommand "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk; mvn -Dmaven.surefire.debug  -Dtest=".expand("%:t:r")." test --offline"<CR>
noremap <leader>mc :VimuxRunCommand "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk; mvn clean" <CR>

noremap <leader>dgs :VimuxRunCommand "~/dotfiles/scripts/runGradleTestDebug.sh ".expand("%") ." --debug-jvm"<CR>
noremap <leader>sgl :call Show_logs(expand("%"))<CR>
noremap <leader>rgs :call RunGradleTest(expand("%"))<CR>
noremap <leader>rgS :call RunAllGradleTest()<CR>
noremap <leader>ol :call OpenLogFile(expand("<cWORD>"))<cr>
vmap <leader>de :'<,'> call DecryptMessage()<CR>

" calls mvn test and open the result in a buffer 
 noremap <leader>rS :call RunMvnTest()<CR>
" calls mvn test for a the current filename as parameter
 noremap <leader>rs :call RunMvnThisTest(expand("%"))<CR>

" start watson time tracking with the current Story ticket
noremap <leader>tim :call StartTimeTracking(g:ActualTicket)<CR>
noremap <leader>tims :call StopTime()<CR>

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" open code completion wit strg+tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"




nmap <leader>rn <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
"Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" calss outline for code on the right side as split
nmap <leader>tg :Tagbar<CR>

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  ::CocFzfList diagnostics<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" format from top to bottom
nmap <leader>fo gg=G''
" use Intelij Formatter and settings
nmap <leader>fO :Dispatch! /home/maren/dotfiles/scripts/format.sh %<cr>
nmap <leader>cpr :Dispatch createPr.sh<cr>


" format json file
nmap <leader>fj :%!python -m json.tool<CR>
" format visual selected json
vmap <leader>fj :'<,'> call BeautifyMvnLog()<CR>


" extract a json from our log 
nmap <leader>log kdggjdGdt{$dT}
nmap <leader>lig dt{$dT}

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"nmap <leader>r :NERDTreeFind<CR> 
"map <leader>n :NERDTreeToggle<CR>

map <leader>n :CocCommand explorer<CR>


" some yanking register stuff
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" use fzf for tags result list
nmap <C-]> <Plug>(fzf_tags)

" yank filename;linenumber to register
nnoremap <leader>yl :let @+=expand("%") . ':' . line(".")<CR>
nnoremap <leader>yf :let @+=expand("%") <CR>
nnoremap <leader>yfn :let @+=expand("%:t") <CR>

" split vertical
map vv <C-W>v
" split horizontal
map ss <C-W>s

" open a new tab
map tt :tabnew<CR>
map tc :tabclose<CR>
" switch tabs
" nnoremap <Tab> gt
" nnoremap <S-Tab> gT

" center cursor for search result
nnoremap n nzzzv
nnoremap N Nzzzv

" open a file reference i a buffer as vertical split
map <leader>gfv :vertical wincmd f<CR>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nmap <c-w>== :set ead=ver ea noea<CR> " set windows equal vertically (^W, =, =)
nmap <c-w>=- :set ead=hor ea noea<CR> " set windows equal horizontally (^W, =, -)

" Debbugging
map <leader>at :CocCommand java.debug.vimspector.start<CR>
map <leader>st <Plug>VimspectorStop<CR>
map <leader>so  <Plug>VimspectorStepOver<CR>
map <leader>si <Plug>VimspectorStepInto<CR>
map <leader>soo <Plug>VimspectorStepOut<CR>
map <leader>vc <Plug>VimspectorContinue<CR>
map <leader>tb <Plug>VimspectorToggleBreakpoint<CR>

imap <leader><TAB> <Plug>vimwiki#tbl#kbd_tab()<CR>

" jumping between vim splits and tmux panes fluently
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

" some self written functions for displaying and handling Jira tickets
 map <leader>jS :call ViewSprint() <CR> 
 map <leader>jru :call ViewRun() <CR> 
 map <leader>js :call SubtaskJira(expand("<cWORD>"))<CR>
 map <leader>jv :call ViewJira(expand("<cWORD>"))<CR>
 map <leader>jco :call CommentJira(expand("<cWORD>"))<CR>
 map <leader>je :call EditJira(expand("<cWORD>"))<CR>
 map <leader>ju :call JiraUnassign(expand("<cWORD>"))<CR>
 map <leader>ja :call JiraAssign(expand("<cWORD>"))<CR>
 map <leader>jr :call JiraReview(expand("<cWORD>"))<CR>
 map <leader>jro :call JiraOpenReview()<CR>
 map <leader>jd :call JiraDone(expand("<cWORD>"))<CR>
 map <leader>jp :call JiraProgress(expand("<cWORD>"))<CR>
 map <leader>jt :call JiraTodo(expand("<cWORD>"))<CR>
 map <leader>jl :call SubtaskJira(g:ActualTicket)<CR>
 map <leader>jm :call MineJira()<CR>
 map <leader>jn :call JiraCreateSubtask(expand("<cWORD>"))<CR>
 map <leader>jpl :call JiraPlatform()<CR>
 map <leader>jo :call JiraOpen("<cWORD>")<CR>

" animmated resizing of splits
nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(10)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(-10)<CR>
" pick the first entriy of the spell correction
imap <leader>C <Esc>[s1z=`]a

" short mappings for vim-surround
map <leader>" ysiw"
map <leader>) ysiw)

" for better got to file in build output
map <leader>ll :s/target\/classes\/META-INF/src\/main\/resources\/META-INF/g <bar> :s/\[/\[ /g <bar> :s/\]/ \]/g <bar> :s/:/:\r/g <CR>

" yank in WORD into register a s or q
map <leader>1 "ayiW
map <leader>2 "syiW
map <leader>3 "qyiW

" paste register a s or q
map <leader>p1 "ap
map <leader>p2 "sp
map <leader>p3 "qp

" using resgister a and s for search and replace Project wide with FAR or buffer with %s
map <leader>RP :Far <C-R>a <C-R>s 
map <leader>rp :%s/<C-R>a/<C-R>s/g
 
" dispatching rust builds
map <leader>ru           :Dispatch ROCKET_PORT=9990 TEST=1  cargo run settings/settings_testing.json <CR>
map <leader>co           :Dispatch cargo build<CR>

map <leader>pri :!lp "%" -o print-quality=3

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


map <leader>pri :!lp "%" -o print-quality=3
