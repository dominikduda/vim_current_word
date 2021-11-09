<img src="https://raw.githubusercontent.com/dominikduda/config_files/master/dd_logo_blue_bg.png" width="300" height="300" />

# vim_current_word
Plugin highlighting word under cursor and all of its occurrences.

![customized](https://raw.githubusercontent.com/dominikduda/vim_current_word/master/gifs/customized.gif)

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
via Vim 8 packages:
```
git clone https://github.com/dominikduda/vim_current_word.git ~/.vim/pack/plugins/start/vim_current_word
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

##### Delay highlighting:

Setting this option to more than 0 will enable delayed highlighting. The value of this variable is a delay in milliseconds.
```vim
let g:vim_current_word#highlight_delay = 0
```

##### Enable/disable highlighting only in focused window:

Disabling this option will make the word highlight persist over window switches and even over focusing different application window.
```vim
let g:vim_current_word#highlight_only_in_focused_window = 1
```

##### Blacklist filetypes:

To avoid specific filetypes, add this variable to your vimrc:
```vim
let g:vim_current_word#excluded_filetypes = ['ruby']
```
If you only want to disable the plugin in some buffers, see the next configuration item.

##### Blacklist buffers:

To prevent the plugin from running in one or more buffers add following to your vimrc:
```vim
autocmd BufAdd NERD_tree_*,your_buffer_name.rb,*.js :let b:vim_current_word_disabled_in_this_buffer = 1
```
The example above disables the plugin in:
- Every buffer which name start with `NERD_tree_`
- Every buffer which name equals `your_buffer_name.rb`
- Every buffer which name ends with `.js`

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

## FAQ:

##### Why doesn't my customized highlight work?
You have to set custom higlights below `colorscheme` in your `.vimrc`.

## Advanced:

Change word under cursor twins or word under cursor match id. You should touch this only if you encounter some `match id already taken` error - theoretically may occur when some other plugin will override required id.
```
let g:vim_current_word#twins_match_id = 502
let g:vim_current_word#current_word_match_id = 502
```

## Credits

Thanks to [Bartosz Mąka](https://github.com/bartoszmaka) for creating the gifs and testing.

Thanks to [Dávid Csákvári](https://github.com/dodie) for information about a script which was the inspiration for this plugin.
