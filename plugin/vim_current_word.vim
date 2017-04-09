function s:highlight_word_under_cursor()
  let character_under_cursor = matchstr(getline('.'), '\%' . col('.') . 'c.')
  " if character_under_cursor alphanumeric
  if character_under_cursor=~#"[A-Za-z0-9\|_]"
    exe printf('match CurrentWord /\V\<%s\>/', escape(expand('<cword>'), '/\'))
  else
    match CurrentWord ''
  endif
endfunction

autocmd CursorMoved * call s:highlight_word_under_cursor()
