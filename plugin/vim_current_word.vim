" Get/set defaults
let g:vim_current_word#enabled = get(g:, 'vim_current_word#enabled', 1)
let g:vim_current_word#current_word_match_id = get(g:, 'vim_current_word#current_word_match_id', 501)
let g:vim_current_word#twins_match_id = get(g:, 'vim_current_word#twins_match_id', 502)
let g:vim_current_word#highlight_twins = get(g:, 'vim_current_word#highlight_twins', 1)
let g:vim_current_word#highlight_current_word = get(g:, 'vim_current_word#highlight_current_word', 1)
let g:vim_current_word#highlight_only_in_focused_window = get(g:, 'vim_current_word#highlight_only_in_focused_window', 1)
let g:vim_current_word#delay_highlight = get(g:, 'vim_current_word#delay_highlight', 0)
let s:disabled_by_focus_lost = 0
let s:disabled_by_insert_mode = 0

augroup vim_current_word
  autocmd!
  if g:vim_current_word#delay_highlight
    autocmd CursorHold * call s:highlight_word_under_cursor()
    autocmd CursorMoved * call s:clear_current_word_matches()
  else
    autocmd CursorMoved * call s:highlight_word_under_cursor()
  endif
  autocmd InsertEnter * call s:handle_insert_enter()
  autocmd InsertLeave * call s:handle_insert_leave()
  if g:vim_current_word#highlight_only_in_focused_window
    autocmd WinLeave * call s:clear_current_word_matches()
    autocmd FocusLost * call s:handle_focus_lost()
    autocmd FocusGained * call s:handle_focus_gained()
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
    call s:highlight_word_under_cursor()
  endif
endfunction

" Disable plugin until insert leave
function! s:handle_insert_enter()
  if !g:vim_current_word#enabled | return 0 | endif
  let s:disabled_by_insert_mode = 1
  call s:vim_current_word_disable()
endfunction

" Enable plugin after insert leave
function! s:handle_insert_leave()
  if !s:disabled_by_insert_mode | return 0 | endif
  let s:disabled_by_insert_mode = 0
  call s:vim_current_word_enable()
  call s:highlight_word_under_cursor()
endfunction

" Disable plugin until next focus
function! s:handle_focus_lost()
  if !g:vim_current_word#enabled | return 0 | endif
  let s:disabled_by_focus_lost = 1
  call s:vim_current_word_disable()
endfunction

" Enable plugin until next defocus
function! s:handle_focus_gained()
  if !s:disabled_by_focus_lost | return 0 | endif
  let s:disabled_by_focus_lost = 0
  call s:vim_current_word_enable()
  call s:highlight_word_under_cursor()
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
