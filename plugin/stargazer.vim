if exists('g:loaded_stargazer') || &compatible
  finish
endif
let g:loaded_stargazer = 1

let g:stargazer_max_qfwin_height = get(g:, 'stargazer_max_qfwin_height', 8)

command -nargs=* PowerStar if !exists('g:stargazer_word') | call stargazer#handle_args(<f-args>) | set hls | else | PowerStarOff | endif
command -nargs=0 -bar PowerStarOff unlet g:stargazer_word | cclose | nohls

function! stargazer#handle_args(...)
  if a:0 == 0
    call stargazer#FindWord(expand('<cword>'), getcwd())
  elseif a:0 == 2
    if !isdirectory(a:2)
      redraw | echomsg 'Second argument must be a directory'
      return
    endif
    if type(a:1) != v:t_string
      redraw | echomsg 'First argument must be a String'
      return
    endif
    call stargazer#FindWord(a:1, a:2)
  elseif a:0 == 1 && type(a:1) == v:t_string
    call stargazer#FindWord(a:1, getcwd())
  elseif a:0 == 1 && isdirectory(a:1)
    call stargazer#FindWord(expand('<cword>'), a:1)
  elseif type(a:1) != v:t_string && !isdirectory(a:1)
    redraw | echomsg 'single argument must be a String or a directory'
    return
  endif
endfunction

function! stargazer#FindWord(word, directory)
  let g:stargazer_word = a:word
  let tmpfile = tempname()
  let win = win_getid()
  call system('grep -rnH "' . g:stargazer_word . '" ' . a:directory . ' ' . &shellpipe . ' ' . tmpfile)
  exec 'cgetfile ' . tmpfile
  let items = len(getqflist()) <= g:stargazer_max_qfwin_height ? len(getqflist()) : g:stargazer_max_qfwin_height
  if items
    silent execute 'copen ' . items
  endif
  call win_gotoid(win)
  let @/ = g:stargazer_word
  call delete(tmpfile)
endfunction
