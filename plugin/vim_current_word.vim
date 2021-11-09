" Get/set defaults
let g:vim_current_word#enabled = get(g:, 'vim_current_word#enabled', 1)
let g:vim_current_word#current_word_match_id = get(g:, 'vim_current_word#current_word_match_id', 501)
let g:vim_current_word#twins_match_id = get(g:, 'vim_current_word#twins_match_id', 502)
let g:vim_current_word#highlight_twins = get(g:, 'vim_current_word#highlight_twins', 1)
let g:vim_current_word#highlight_current_word = get(g:, 'vim_current_word#highlight_current_word', 1)
let g:vim_current_word#highlight_only_in_focused_window = get(g:, 'vim_current_word#highlight_only_in_focused_window', 1)
let g:vim_current_word#highlight_delay = get(g:, 'vim_current_word#highlight_delay', 0)
let g:vim_current_word#excluded_filetypes = get(g:, 'vim_current_word#excluded_filetypes', [])

augroup vim_current_word
  autocmd!
  autocmd BufEnter * call vim_current_word#pre_highlight()
  autocmd CursorMoved * call vim_current_word#pre_highlight()
  autocmd InsertEnter * call vim_current_word#handle_insert_enter()
  autocmd InsertLeave * call vim_current_word#handle_insert_leave()
  if g:vim_current_word#highlight_only_in_focused_window
    autocmd WinLeave * call vim_current_word#clear_current_word_matches()
    autocmd FocusLost * call vim_current_word#handle_focus_lost()
    autocmd FocusGained * call vim_current_word#handle_focus_gained()
  endif
augroup END

command! VimCurrentWordToggle call vim_current_word#vim_current_word_toggle()
