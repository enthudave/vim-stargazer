# vim-stargazer
star command `*` combined with `grep` in $CWD.  

Provides one command `:Powerstar {word}`  
This is a 'toggle' command, pressing it a second time, removes the search highlight 
and closes the quickfix window.

To use with a mapping for searching the word under the cursor:  
in your vimrc : `nnoremap <silent> <localleader>p :exec 'PowerStar ' . expand('<cword>')<CR>`
