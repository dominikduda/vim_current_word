let s:word_characters = '[A-Za-z0-9_]'

" Checks if passed highlight exists
func HlExists(hl)
  if !hlexists(a:hl)
    return 0
  endif
  redir => hlstatus
  exe "silent hi" a:hl
  redir END
  return (hlstatus !~ "cleared")
endfunc

" Set default twins color
if !HlExists('CurrentWordTwins')
  hi CurrentWordTwins ctermbg=53
end

" Set default word color
if !HlExists('CurrentWord')
  hi CurrentWord ctermbg=52
end

function s:highlight_word_under_cursor()
  let character_under_cursor = matchstr(getline('.'), '\%' . col('.') . 'c.')
  if character_under_cursor=~#s:word_characters
    exe printf('match CurrentWordTwins /\V\<%s\>/', escape(expand('<cword>'), '/\'))
    exe '2match CurrentWord /\%['.s:word_characters.']\+\%#'.s:word_characters.'\+/'
  else
    match CurrentWordTwins ''
    match CurrentWord ''
  endif
endfunction

autocmd CursorMoved * call s:highlight_word_under_cursor()
