# vim-stargazer
star command `*` combined with `grep`

Provides one command `:Powerstar {regex} {directory}`  
Searches for {regex} in {directory}.  
The matches will be highlighted as with the `*` command, a quickfixlist will be shown with the  
matches in the (optional) directory argument.  
If no regex is supplied it will use the word under the cursor.  
If no directory is supplied it will use the working directory.  
This is a 'toggle' command, running it a second time, removes the search highlight 
and closes the quickfix window.  
(No need for arguments the second time, but they don't hurt)  

You can set a maximum height for the quickfix window using the `g:stargazer_max_qfwin_height` variable.  
For example:  
`let g:stargazer_max_qfwin_height = 5` (the default value is 8)
