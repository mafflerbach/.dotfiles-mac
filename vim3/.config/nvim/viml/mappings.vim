map <leader>pri :!lp "%" -o print-quality=3
nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(10)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(-10)<CR>


nmap gx :silent execute "!xdg-open " . shellescape("<cWORD>")<cr>

nmap <leader>oy :Dispatch! youtube-viewer '<cWORD>'<cr>

tmap <C-o> <C-\><C-n>

