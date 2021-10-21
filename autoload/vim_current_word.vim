let g:vim_current_word#disabled_by_focus_lost = 0
let g:vim_current_word#disabled_by_insert_mode = 0
let g:vim_current_word#timer_id = 0

" Clear previously scheduled highlight
function! vim_current_word#clear_scheduled_highlight()
  if g:vim_current_word#timer_id
    call timer_stop(g:vim_current_word#timer_id)
    let g:vim_current_word#timer_id = 0
  endif
endfunction

" Perform highlight with delay
function! vim_current_word#schedule_highlight()
  let g:vim_current_word#timer_id = timer_start(g:vim_current_word#highlight_delay, 'vim_current_word#highlight_word_under_cursor')
endfunction

" Schedule highlight or do it instantly
function! vim_current_word#pre_highlight()
  call vim_current_word#clear_current_word_matches()
  let l:vim_current_word_disabled_in_this_buffer = get(b:, 'vim_current_word_disabled_in_this_buffer', 0)
  if !g:vim_current_word#enabled || index(g:vim_current_word#excluded_filetypes, &filetype) >= 0 || l:vim_current_word_disabled_in_this_buffer | return 0 | endif
  if g:vim_current_word#highlight_delay
    call vim_current_word#schedule_highlight()
  else
    call vim_current_word#highlight_word_under_cursor()
  end
endfunction

" Check if highlight group exists
function! vim_current_word#hl_exists(hl)
  if !hlexists(a:hl)
    return 0
  endif
  redir => hlstatus
  exe "silent hi" a:hl
  redir END
  return (hlstatus !~ "cleared")
endfunc

" Set default twins highlight
if !vim_current_word#hl_exists('CurrentWordTwins')
  hi CurrentWordTwins cterm=underline gui=underline
end

" Set default word highlight
if !vim_current_word#hl_exists('CurrentWord')
  hi link CurrentWord Search
end

" Toggle plugin
function! vim_current_word#vim_current_word_toggle()
  if g:vim_current_word#enabled == 1
    call vim_current_word#vim_current_word_disable()
  else
    call vim_current_word#vim_current_word_enable()
    call vim_current_word#pre_highlight()
  endif
endfunction

" Disable plugin until insert leave
function! vim_current_word#handle_insert_enter()
  if !g:vim_current_word#enabled | return 0 | endif
  let g:vim_current_word#disabled_by_insert_mode = 1
  call vim_current_word#vim_current_word_disable()
endfunction

" Enable plugin after insert leave
function! vim_current_word#handle_insert_leave()
  if !g:vim_current_word#disabled_by_insert_mode | return 0 | endif
  let g:vim_current_word#disabled_by_insert_mode = 0
  call vim_current_word#vim_current_word_enable()
  call vim_current_word#pre_highlight()
endfunction

" Disable plugin until next focus
function! vim_current_word#handle_focus_lost()
  if !g:vim_current_word#enabled | return 0 | endif
  let g:vim_current_word#disabled_by_focus_lost = 1
  call vim_current_word#vim_current_word_disable()
endfunction

" Enable plugin until next defocus
function! vim_current_word#handle_focus_gained()
  if !g:vim_current_word#disabled_by_focus_lost | return 0 | endif
  let g:vim_current_word#disabled_by_focus_lost = 0
  call vim_current_word#vim_current_word_enable()
  call vim_current_word#pre_highlight()
endfunction

" Enable plugin
function! vim_current_word#vim_current_word_enable()
  let g:vim_current_word#enabled = 1
endfunction

" Disable plugin
function! vim_current_word#vim_current_word_disable()
  call vim_current_word#clear_current_word_matches()
  let g:vim_current_word#enabled = 0
endfunction

" Higlight current word and twins (aka 'main')
function! vim_current_word#highlight_word_under_cursor(...)
  call vim_current_word#clear_current_word_matches()
  if vim_current_word#character_under_cursor()=~#'\k'
    call vim_current_word#add_current_word_matches()
  endif
endfunction

" Get character under cursor
function! vim_current_word#character_under_cursor()
  return matchstr(getline('.'), '\%' . col('.') . 'c.')
endfunction

" Add plugin matches
function! vim_current_word#add_current_word_matches()
  if g:vim_current_word#highlight_twins
    call matchadd('CurrentWordTwins', '\%(\k*\%#\k*\)\@!\<\V'.substitute(expand('<cword>'), '\\', '\\\\', 'g').'\m\>', -5, g:vim_current_word#twins_match_id)
  endif
  if g:vim_current_word#highlight_current_word
    call matchadd('CurrentWord', '\k*\%#\k*', -4, g:vim_current_word#current_word_match_id)
  endif
endfunction

" Clear plugin matches
function! vim_current_word#clear_current_word_matches()
  call vim_current_word#clear_scheduled_highlight()
  if vim_current_word#current_word_match_exist(g:vim_current_word#current_word_match_id)
    call matchdelete(g:vim_current_word#current_word_match_id)
  endif
  if vim_current_word#current_word_match_exist(g:vim_current_word#twins_match_id)
    call matchdelete(g:vim_current_word#twins_match_id)
  endif
endfunction

" Check if plugin match exists
function! vim_current_word#current_word_match_exist(id)
  let matches_list = getmatches()
  for match in matches_list
    if get(match, 'id', '-1') == a:id
      return 1
    end
  endfor
  return 0
endfunction
