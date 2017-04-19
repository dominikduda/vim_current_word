# vim_current_word
Plugin highligting word under cursor and all of its occurrences.

![customized](https://raw.githubusercontent.com/dominikduda/vim_current_word/master/gifs/customized.gif)
![default](https://raw.githubusercontent.com/dominikduda/vim_current_word/master/gifs/default.gif)

Why should you use it?
  - Helps predict how vim word movements (`w`, `e`, `b`) will behave
  - Plays well with `*` and `#`
  - Instant access to information where the variable under cursor is used
  - Works out of the box!

Plugin determines what is a word based on what is a keyword in current file type. For example `foo#bar` in `.vim` file will be a single word (because vimscript allows to put `#` as part of variable name), but in `.rb` file `foo#bar` will be considered as two words (because `#` starts comment).

## Installation
via `Plug`, `Neobundle` or `Vundle`:
```
Plug 'dominikduda/vim_current_word'
NeoBundle 'dominikduda/vim_current_word'
Plugin 'dominikduda/vim_current_word'
```

## Quick start

By default vim_current_word will underline twins of word under cursor and use your `Search` highlight group to color word under cursor. If you want to change this behavior see the [styling](https://github.com/dominikduda/vim_current_word#styling) section.

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

Enable/disable highlighting word under cursor:
```
let g:vim_current_word#highlight_current_word = 1
```

## Styling

Replace `XXXXXX` with hex code of color (for gui Vim)

Replace `XXX` with [terminal color code](http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html) (for terminal Vim)

For `gui=` and `cterm=` choose special styles you want to use for gui and terminal vim respectively. If you do not want special styles use `=NONE`.

`(...)bg` -> background

`(...)fg` -> font color


Change highlight style of word under cursor twins:
```
hi CurrentWordTwins guifg=#XXXXXX guibg=#XXXXXX gui=underline,bold,italic ctermfg=XXX ctermbg=XXX cterm=underline,bold,italic
```

Change highlight style of word under cursor:
```
hi CurrentWordTwins guifg=#XXXXXX guibg=#XXXXXX gui=underline,bold,italic ctermfg=XXX ctermbg=XXX cterm=underline,bold,italic
```

To achieve the style from the first gif (in terminal vim):
```
hi CurrentWord ctermbg=53
hi CurrentWordTwins ctermbg=237
```

## Advanced:

Change word under cursor twins or word under cursor match id. You should touch this only if you encounter some `match id already taken` error - theoretically may occur when some other plugin will override required id.
```
let g:vim_current_word#twins_match_id = 502
let g:vim_current_word#current_word_match_id = 502
```
