if exists('g:loaded_stargazer') || &compatible
  finish
endif
let g:loaded_stargazer = 1

command -nargs=1 PowerStar :call stargazer#FindWord(<f-args>) | set hls

function! stargazer#FindWord(word)
  if exists('g:found_a_word')
    unlet g:found_a_word
    let @/ = ''
    cclose
    return
  endif
  let dir = getcwd()
  let g:found_a_word = 1
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
