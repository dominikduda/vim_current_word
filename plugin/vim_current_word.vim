" Get/set defaults
let g:vim_current_word#enabled = get(g:, 'vim_current_word#enabled', 1)
let g:vim_current_word#current_word_match_id = get(g:, 'vim_current_word#current_word_match_id', 501)
let g:vim_current_word#twins_match_id = get(g:, 'vim_current_word#twins_match_id', 502)
let g:vim_current_word#highlight_twins = get(g:, 'vim_current_word#highlight_twins', 1)
let g:vim_current_word#highlight_current_word = get(g:, 'vim_current_word#highlight_current_word', 1)
let g:vim_current_word#highlight_only_in_focused_window = get(g:, 'vim_current_word#highlight_only_in_focused_window', 1)

augroup vim_current_word
  autocmd!
  autocmd CursorMoved * call s:highlight_word_under_cursor()
  autocmd InsertEnter * call s:vim_current_word_disable()
  autocmd InsertLeave * call s:vim_current_word_enable()
  if g:vim_current_word#highlight_only_in_focused_window
    autocmd WinLeave * call s:clear_current_word_matches()
    autocmd FocusLost * call s:vim_current_word_disable()
    autocmd FocusGained * call s:vim_current_word_enable()
    autocmd FocusGained * call s:highlight_word_under_cursor()
  endif
augroup END

command! VimCurrentWordToggle call s:vim_current_word_toggle()

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

" Set default twins highlight
if !s:hl_exists('CurrentWordTwins')
  hi CurrentWordTwins cterm=underline gui=underline
end

" Set default word highlight
if !s:hl_exists('CurrentWord')
  hi link CurrentWord Search
end

" Toggle plugin
function! s:vim_current_word_toggle()
  if g:vim_current_word#enabled == 1
    call s:vim_current_word_disable()
  else
    call s:vim_current_word_enable()
  endif
endfunction

" Enable plugin
function! s:vim_current_word_enable()
  let g:vim_current_word#enabled = 1
endfunction

" Disable plugin
function! s:vim_current_word_disable()
  call s:clear_current_word_matches()
  let g:vim_current_word#enabled = 0
endfunction

" Higlight current word and twins (aka 'main')
function! s:highlight_word_under_cursor()
  if !g:vim_current_word#enabled | return 0 | endif
  call s:clear_current_word_matches()
  if s:character_under_cursor()=~#'\k'
    call s:add_current_word_matches()
  endif
endfunction

" Get character under cursor
function! s:character_under_cursor()
  return matchstr(getline('.'), '\%' . col('.') . 'c.')
endfunction

" Add plugin matches
function! s:add_current_word_matches()
  if g:vim_current_word#highlight_twins
    call matchadd('CurrentWordTwins', '\%(\k*\%#\k*\)\@!\<\V'.substitute(expand('<cword>'), '\\', '\\\\', 'g').'\m\>', -5, g:vim_current_word#twins_match_id)
  endif
  if g:vim_current_word#highlight_current_word
    call matchadd('CurrentWord', '\k*\%#\k*', -4, g:vim_current_word#current_word_match_id)
  endif
endfunction

" Clear plugin matches
function! s:clear_current_word_matches()
  if s:current_word_match_exist(g:vim_current_word#current_word_match_id)
    call matchdelete(g:vim_current_word#current_word_match_id)
  endif
  if s:current_word_match_exist(g:vim_current_word#twins_match_id)
    call matchdelete(g:vim_current_word#twins_match_id)
  endif
endfunction

" Check if plugin match exists
function! s:current_word_match_exist(id)
  let matches_list = getmatches()
  for match in matches_list
    if get(match, 'id', '-1') == a:id
      return 1
    end
  endfor
  return 0
endfunction
