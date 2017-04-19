# vim_current_word
Plugin highligting word under cursor and all of its occurrences.

Why should you use it?
  - Helps predict how vim word movements (with `w`, `e`, `b`) will behave
  - Instant access to information where the variable under cursor is used

## Installation with `Plug`:
Put this in your `.vimrc` in suitable place.
```
Plug 'dominikduda/vim_current_word'
```
Then restart vim, open your `.vimrc` and enter the `:PlugInstall` command.

Installation via other plugin managers is analogic.

## Quick start
By default vim_current_word will underline twins of word under cursor and use your `IncSearch` highlight group to color word under cursor. If you want to change this behavior see the styling section.

Plugin defines `:VimCurrentWordToggle` command which enables/disables plugin on the fly.

## Customization (values written here are defaults)

Enable/disable plugin:
```
let g:vim_current_word#enabled = 1
```

Enable/disable highlighting twins of word under cursor:
```
let g:vim_current_word#highlight_twins = 1
```

Enable/disable highlighitng word under cursor:
```
let g:vim_current_word#highlight_current_word = 1
```

## Styling

Change highlight style of word under cursor twins:
```
hi CurrentWordTwins ctermbg=237
```

Change highlight style of word under cursor:
```
hi CurrentWord ctermbg=53
```

## Advanced customization:

Change word under cursor twins match id (you should touch this only if you encounter some `match id already taken` error - theoretically may occur when some other plugin will override needed id)
```
let g:vim_current_word#twins_match_id = 502
```

Change word under cursor match id (you should touch this only if you encounter some `match id already taken` error - theoretically may occur when some other plugin will override needed id)
```
let g:vim_current_word#current_word_match_id = 502
```
