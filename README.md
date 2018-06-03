# vim-stargazer
star command `*` combined with `:grep` in $CWD.  
Uses your `'grepprg'`, read `:h 'grepprg'`

Provides one command `:Powerstar {word}`

To use with a mapping for searching the word under the cursor:  
in your vimrc : `nnoremap <silent> <localleader>p :exec 'PowerStar ' . expand('<cword>')<CR>`
