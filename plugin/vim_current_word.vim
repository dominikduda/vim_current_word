" TODO: disable in certain buffers (help, nerdtree?, quickfix ...)

" Check if gihglight group exists
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
  " if !exists('b:word_characters')
  "   let b:word_characters = s:word_characters_regex()
  " endif
  let character_under_cursor = matchstr(getline('.'), '\%' . col('.') . 'c.')
  " if character_under_cursor=~#b:word_characters
  if character_under_cursor=~#'\k'
    let current_word =expand('<cword>')
    " exe '2match CurrentWordTwins /\V\<'.current_word.'\>/'
    exe '2match CurrentWordTwins /\k*\<\V'.current_word.'\m\>\k*/'
" /\k*\%#\k*
    exe '3match CurrentWord /\k*\%#\k*/'
    " exe '3match CurrentWord /\%[['.current_word.']]\+\%#\%[['.current_word.']]\+/'
  else
    2match none
    3match none
  endif
endfunction

autocmd! CursorMoved * call s:highlight_word_under_cursor()
