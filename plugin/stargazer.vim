if exists('g:loaded_stargazer') || &compatible
  finish
endif
let g:loaded_stargazer = 1

command -nargs=1 PowerStar if !exists('g:found_a_word') | call stargazer#FindWord(<f-args>) | set hls | else | PowerStarOff | endif
command -nargs=0 -bar PowerStarOff unlet g:found_a_word | cclose | set nohls

function! stargazer#FindWord(word)
  let dir = getcwd()
  let g:found_a_word = a:word
  let tmpfile = tempname()
  let win = win_getid()
  call system(&grepprg . ' ' . a:word . ' ' . dir . ' ' . &shellpipe . ' ' . tmpfile)
  exec 'cgetfile ' . tmpfile
  let items = len(getqflist())
  if items
    silent execute 'copen ' . items
  endif
  call win_gotoid(win)
  let @/ = a:word
endfunction
