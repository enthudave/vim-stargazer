if exists('g:loaded_stargazer') || &compatible
  finish
endif
let g:loaded_stargazer = 1

let g:stargazer_max_qfwin_height = get(g:, 'stargazer_max_qfwin_height', 8)

command -nargs=+ PowerStar if !exists('g:stargazer_word') | call stargazer#FindWord(<f-args>) | set hls | else | PowerStarOff | endif
command -nargs=0 -bar PowerStarOff unlet g:stargazer_word | cclose | nohls

function! stargazer#FindWord(...)
  let g:stargazer_word = len(a:1) ? a:1 : expand('<cword>')
  let dir = len(a:2) && isdirectory(a:2) ? a:2 : getcwd()
  let tmpfile = tempname()
  let win = win_getid()
  call system('grep -rnH "' . g:stargazer_word . '" ' . dir . ' ' . &shellpipe . ' ' . tmpfile)
  exec 'cgetfile ' . tmpfile
  let items = len(getqflist()) <= g:stargazer_max_qfwin_height ? len(getqflist()) : g:stargazer_max_qfwin_height
  if items
    silent execute 'copen ' . items
  endif
  call win_gotoid(win)
  let @/ = g:stargazer_word
"  delete(tmpfile)
endfunction
