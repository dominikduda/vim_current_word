[![donate_with_bitcoins](https://img.shields.io/badge/Bitcoin-Donate-ffc600.svg?logo=data%3Aimage%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAMAAAAolt3jAAABWVBMVEUAAAD1khf1jxf1kRb3kxf1khf3khf1kRf3khn3kRj3lRz3khj1kRj3kxj1kRj3kxj3liP1khj2kxj3kxv2khj3khn2khj2lyT2kxn4kxn5qUn2khn2mCf4oz72khn2khn2khn3khn3kxr3kxv3lBz3lB33lyP3lyT3mCX3min3mir3njP3nzX3oDX3oTj3oTr4oz34pUD4pUH4p0X4qUr4qkv4qk34sFj5slz5s175tGH5tWP5t2j5uGn5uWv5u3D5vXT6vXX6vnX6v3j6wX36wn%2F6w4H6xIL6xYX6yY37zZb7zZf7z5r70J370qH706P72a%2F82bD83bj837z84sL848T85cj85cr958z9583958796M796M%2F96dD96dL97dn97tz9793979798OD98uX%2B8%2Bb%2B9Oj%2B9er%2B9ez%2B9u3%2B9%2B7%2B%2BPD%2B%2B%2Fj%2B%2FPn%2B%2FPr%2B%2Ffv%2B%2Ffz%2B%2Fv7%2F%2Fv5cp9%2FiAAAAIHRSTlMANjc4a2xsbYSFhYaHwsTExMXX19jY2dnc3Nzd3d3z9P0zBPsAAAC8SURBVAjXBcHJbsIwFAXQaz%2BTBDKQMIiKKquKZf%2F%2FT7pBbBokUIUQJrExeXbccwQAylQV7OgmQABptXeHMNkf7aGQfqy%2FYn1LfJVfmKjJWLQFrd%2FSRKfmBYKl62l5qEdhJQGxSt3z0hcqztQCoFKuvuXm14hcSsQktyctIhtA2rja1%2Frv2PGuhFE827VZ9vlqkiGAKcDrhW%2B3DZ%2Bvj0GFPk%2F4LLtXuPshEoLjaZTd0%2BgbQwCgOZWx5%2FcE%2FAPW1Fv3gHREswAAAABJRU5ErkJggg%3D%3D)](https://blockchain.info/payment_request?address=1DMdu2m8qX4svMdsnPjRevh2wvxCy2hy8n&message=dominikduda)

![logo_with_title](https://raw.githubusercontent.com/dominikduda/config_files/master/logo_with_title.png)

# vim_current_word
Plugin highlighting word under cursor and all of its occurrences.

![customized](https://raw.githubusercontent.com/dominikduda/vim_current_word/master/gifs/customized.gif)
![default](https://raw.githubusercontent.com/dominikduda/vim_current_word/master/gifs/default.gif)

##### Why should you use it?
  - Helps predict how vim word movements (`w`, `e`, `b`) will behave
  - Plays well with `*` and `#`
  - Instant access to information where the variable under cursor is used
  - Works out of the box!

##### The most importantly it solves all the problems other similar plugins have with knowing what exactly is a word and when cursor is on the word.

Plugin determines what is a word based on what is a keyword in current file type. For example `foo#bar` in `.vim` file will be a single word (because vimscript allows to put `#` as part of variable name), but in `.rb` file `foo#bar` will be considered as two words (because `#` starts comment).

## Installation
via `Plug`, `Neobundle` or `Vundle`:
```
Plug 'dominikduda/vim_current_word'
NeoBundle 'dominikduda/vim_current_word'
Plugin 'dominikduda/vim_current_word'
```
via `Pathogen`:
```
git clone https://github.com/dominikduda/vim_current_word.git ~/.vim/bundle/vim_current_word
```

## Quick start

By default vim_current_word will underline twins of word under cursor and use your `Search` highlight group to color word under cursor. If you want to change this behavior see the [styling](https://github.com/dominikduda/vim_current_word#styling) section.

Plugin defines `:VimCurrentWordToggle` command which enables/disables plugin on the fly.

## Customization (values written here are defaults)

#### Enable/disable highlighting of:

```vim
" Twins of word under cursor:
let g:vim_current_word#highlight_twins = 1
" The word under cursor:
let g:vim_current_word#highlight_current_word = 1
```

##### Enable/disable highlighting only in focused window:

Disabling this option will make the word highlight persist over window switches and even over focusing different application window.
```vim
let g:vim_current_word#highlight_only_in_focused_window = 1
```

##### Enable/disable plugin:
```vim
let g:vim_current_word#enabled = 1
```

## Styling

#### To change any style paste related code into your `.vimrc`

Change highlight style of **twins of word under cursor**:
```vim
hi CurrentWordTwins guifg=#XXXXXX guibg=#XXXXXX gui=underline,bold,italic ctermfg=XXX ctermbg=XXX cterm=underline,bold,italic
"                          └┴┴┴┴┤        └┴┴┴┴┤     └┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┤         └┴┤         └┴┤       └┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┤
"    gui-vim font color hex code│             │   gui-vim special styles│           │           │ console-vim special styles│
"    ───────────────────────────┘             │   ──────────────────────┘           │           │ ──────────────────────────┘
"            gui-vim background color hex code│     console-vim font term color code│           │
"            ─────────────────────────────────┘     ────────────────────────────────┘           │
"                                                         console-vim background term color code│
"                                                         ──────────────────────────────────────┘
```

Change highlight style of the **word under cursor**:
```vim
hi CurrentWord guifg=#XXXXXX guibg=#XXXXXX gui=underline,bold,italic ctermfg=XXX ctermbg=XXX cterm=underline,bold,italic
"                     └┴┴┴┴┴──┐     └┴┴┴┴┤     └┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┤         └┴┤         └┴┤       └┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┤
"  gui-vim font color hex code│          │   gui-vim special styles│           │           │ console-vim special styles│
"  ───────────────────────────┘          │   ──────────────────────┘           │           │ ──────────────────────────┘
"       gui-vim background color hex code│     console-vim font term color code│           │
"       ─────────────────────────────────┘     ────────────────────────────────┘           │
"                                                    console-vim background term color code│
"                                                    ──────────────────────────────────────┘
```

To achieve the style from the first gif (in terminal vim):
```vim
hi CurrentWord ctermbg=53
hi CurrentWordTwins ctermbg=237
```

Rather important notes:
- If you do not want any special styles just ommit them (or use `gui=NONE cterm=NONE`)
- [Here](http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html) you can find color codes for console-vim

## Advanced:

Change word under cursor twins or word under cursor match id. You should touch this only if you encounter some `match id already taken` error - theoretically may occur when some other plugin will override required id.
```
let g:vim_current_word#twins_match_id = 502
let g:vim_current_word#current_word_match_id = 502
```

## Credits

Thanks to [Bartosz Mąka](https://github.com/bartoszmaka) for creating the gifs and testing.

Thanks to [Dávid Csákvári](https://github.com/dodie) for information about a script which was the inspiration for this plugin.

## Donations

If you like the plugin, you can thank me by sending BTC to following address: **1DMdu2m8qX4svMdsnPjRevh2wvxCy2hy8n**
