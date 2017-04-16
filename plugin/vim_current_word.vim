" Defaults
let g:vim_current_word_enabled = 1
let g:vim_current_word_match_id = 501
let g:vim_current_word_twins_match_id = 502

function! s:vim_current_word_toggle()
  if g:vim_current_word_enabled == 1
    call s:vim_current_word_disable()
  else
    call s:vim_current_word_enable()
  endif
endfunction

function! s:vim_current_word_enable()
  let g:vim_current_word_enabled = 1
endfunction

function! s:vim_current_word_disable()
  if s:current_word_matches_exist()
    call s:clear_current_word_matches()
  endif
  let g:vim_current_word_enabled = 0
endfunction

" Check if highlight group exists
function! s:hl_exists(hl)
  if !hlexists(a:hl)
    return 0
  endif
  redir => hlstatus
  exe "silent hi" a:hl
  redir END
  return (hlstatus !~ "cleared")
endfunc

" Set default twins color
if !s:hl_exists('CurrentWordTwins')
  hi CurrentWordTwins cterm=underline
end

" Set default word color
if !s:hl_exists('CurrentWord')
  hi CurrentWord ctermbg=237
end

function! s:highlight_word_under_cursor()
  if !g:vim_current_word_enabled | return 0 | endif
  if s:current_word_matches_exist()
    call s:clear_current_word_matches()
  endif
  let character_under_cursor = matchstr(getline('.'), '\%' . col('.') . 'c.')
  if character_under_cursor=~#'\k'
    let current_word = expand('<cword>')
    call matchadd('CurrentWordTwins', '\k*\<\V'.current_word.'\m\>\k*', -5, 502)
    call matchadd('CurrentWord', '\k*\%#\k*', -4, 501)
  endif
endfunction

function! s:clear_current_word_matches()
  call matchdelete(501)
  call matchdelete(502)
endfunction

function! s:current_word_matches_exist()
  let matches_list = getmatches()
  for match in matches_list
    if get(match, 'id', '-1') == 501 || get(match, 'id', '-1') == 502
      return 1
    end
  endfor
  return 0
endfunction

autocmd CursorMoved * call s:highlight_word_under_cursor()
autocmd InsertEnter * call s:vim_current_word_disable()
autocmd InsertLeave * call s:vim_current_word_enable()
command! VimCurrentWordToggle call s:vim_current_word_toggle()
