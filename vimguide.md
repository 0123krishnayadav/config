# Vim Guide

A practical guide: learn the *grammar* once, and hundreds of commands follow from it.
Written for the macOS system Vim (`/usr/bin/vim`, 9.1, built with `+clipboard`).

> New to Vim? Run `vimtutor` in the terminal first (about 30 minutes). Then come back here.

---

## 0. Survival kit

| Keys | What it does |
|---|---|
| `Esc` | Back to Normal mode (when in doubt, press it) |
| `:w` / `:q` / `:wq` / `:x` | Save / quit / save and quit / save only if changed and quit |
| `:q!` | Quit and throw away changes |
| `:wa` / `:qa!` | Save all / quit all without saving |
| `u` / `Ctrl-r` | Undo / redo |
| `:help {topic}` | Built-in docs, e.g. `:help ciw`, `:help text-objects` |

---

## 1. Modes

| Mode | Enter with | Used for |
|---|---|---|
| Normal | `Esc` | Moving and running commands (you live here) |
| Insert | `i a I A o O` | Typing text |
| Visual | `v` (chars), `V` (lines), `Ctrl-v` (block) | Selecting |
| Command-line | `:` `/` `?` | Ex commands and searching |
| Replace | `R` | Overtyping |

**Rule of thumb:** go into Insert mode, type, and get out again. Don't move around in Insert mode.

---

## 2. The grammar: `[count] operator [count] motion | text-object`

This is the single most important idea in Vim.

**Operators (verbs)**

| Key | Verb |
|---|---|
| `d` | delete (cut) |
| `c` | change (delete and enter Insert mode) |
| `y` | yank (copy) |
| `>` / `<` | indent / outdent |
| `=` | auto-indent |
| `gu` / `gU` / `g~` | lowercase / uppercase / toggle case |
| `gq` | reflow/wrap text |

**Combine them with any motion or text object:**

| Command | Meaning |
|---|---|
| `dw` | delete to the start of the next word |
| `d3w` / `3dw` | delete 3 words |
| `c$` (= `C`) | change to the end of the line |
| `yG` | yank to the end of the file |
| `>ip` | indent the paragraph |
| `gUiw` | uppercase the word |
| `dt)` | delete up to (not including) `)` |

**Double the operator to act on the whole line:** `dd`, `cc`, `yy`, `>>`, `==`, `gUU`.

---

## 3. Motions (nouns: *where* to)

**Characters and lines**

| Keys | Moves to |
|---|---|
| `h j k l` | left, down, up, right |
| `0` / `^` / `$` | line start / first non-blank character / line end |
| `gg` / `G` / `42G` (or `:42`) | top of file / bottom of file / line 42 |

**Words**

| Keys | Moves to |
|---|---|
| `w` / `b` / `e` | next word start / previous word start / word end |
| `W` / `B` / `E` | the same, but WORDs (split on whitespace only, so `foo.bar()` counts as one) |

**Within a line: find characters (very fast)**

| Keys | Moves to |
|---|---|
| `f{c}` / `F{c}` | onto the next / previous `{c}` |
| `t{c}` / `T{c}` | just before the next / just after the previous `{c}` |
| `;` / `,` | repeat the last `f/t` forward / backward |

**Larger jumps**

| Keys | Moves to |
|---|---|
| `}` / `{` | next / previous blank line (paragraph) |
| `%` | matching `()[]{}` |
| `H` / `M` / `L` | top / middle / bottom of the screen |
| `Ctrl-d` / `Ctrl-u` | half a page down / up |
| `Ctrl-f` / `Ctrl-b` | a full page down / up |
| `zz` / `zt` / `zb` | scroll so the cursor line is centred / at the top / at the bottom |
| `*` / `#` | next / previous occurrence of the word under the cursor |

---

## 4. Text objects (the superpower)

Use these after an operator or in Visual mode. `i` = *inner*, `a` = *around* (includes the surrounding quotes/brackets/space).

| Object | Selects |
|---|---|
| `iw` / `aw` | word |
| `is` / `as` | sentence |
| `ip` / `ap` | paragraph |
| `i"` `a"` `i'` `i\`` | inside / around quotes |
| `i(` (= `ib`) / `a(` | inside / around parentheses |
| `i{` (= `iB`) / `a{` | inside / around braces |
| `i[` / `i<` | inside brackets / angle brackets |
| `it` / `at` | inside / around an HTML/XML tag |

**Everyday combos:** `ciw` (change word), `ci"` (change string), `di(` (empty the arguments), `yap` (copy paragraph), `vit` (select tag contents), `da{` (delete a block).

The cursor only needs to be *inside* the object, not at its start. `ci"` even jumps forward to the next string on the line.

---

## 5. Editing essentials

| Keys | Action |
|---|---|
| `i` / `a` | insert before / after the cursor |
| `I` / `A` | insert at line start / line end |
| `o` / `O` | open a new line below / above |
| `x` / `X` | delete the character under / before the cursor |
| `r{c}` | replace one character |
| `s` / `S` | substitute a character / the whole line (then Insert mode) |
| `D` / `C` / `Y` | delete / change to end of line; yank the line |
| `J` / `gJ` | join with the next line (with / without a space) |
| `p` / `P` | paste after / before |
| `~` | toggle case of the character |
| `Ctrl-a` / `Ctrl-x` | increment / decrement the number under or after the cursor |
| `xp` / `ddp` | swap two characters / swap two lines |
| `:m +1` / `:m -2` | move the line down / up |

### The dot command `.`

`.` repeats the last change. Build every edit so that it's repeatable:

```
*        → jump to the next "foo"
ciwbar   → change it to "bar"   (then Esc)
n.       → next match, repeat
n.n.n.   → keep going, skipping any with just n
```

**In Insert mode:** `Ctrl-w` deletes the previous word, `Ctrl-u` deletes to the line start, `Ctrl-o {cmd}` runs one Normal-mode command, `Ctrl-n` / `Ctrl-p` autocomplete from words in open buffers, and `Ctrl-r {reg}` pastes a register.

---

## 6. Visual mode

| Keys | Action |
|---|---|
| `v` / `V` / `Ctrl-v` | select characters / lines / a block |
| `o` | jump to the other end of the selection |
| `gv` | reselect the last selection |
| `>` `<` `=` `d` `c` `y` `u` `U` `J` | act on the selection |
| `:` | run an Ex command on the selected lines (`:'<,'>` is filled in for you) |

**Multi-line edit with block mode:**
`Ctrl-v` → move down with `j` → `I` → type `// ` → `Esc`. The text appears on every line.
Use `A` instead of `I` to append, or `$A` to append at the end of lines of different lengths.

---

## 7. Search and replace

| Keys | Action |
|---|---|
| `/pat` / `?pat` | search forward / backward |
| `n` / `N` | next / previous match |
| `*` / `#` | search for the word under the cursor |
| `:noh` | clear highlighting |
| `/\cpat` | case-insensitive just this once |
| `/\vpat` | "very magic": regex without the backslash soup (`\v(foo|bar)+`) |

**Substitute:** `:[range]s/old/new/[flags]`

| Command | Effect |
|---|---|
| `:s/a/b/` | first match on the current line |
| `:s/a/b/g` | every match on the line |
| `:%s/a/b/g` | the whole file |
| `:%s/a/b/gc` | the whole file, confirming each one (`y n a q`) |
| `:10,20s/a/b/g` | lines 10 to 20 |
| `:'<,'>s/a/b/g` | the visual selection |
| `:%s//b/g` | reuse the last search pattern (search first with `/`, then replace) |
| `:%s/\<foo\>/bar/g` | whole word only |
| `:%s/\(\w\+\) \(\w\+\)/\2 \1/` | swap two words using capture groups |

In the replacement, `&` is the whole match, `\r` is a newline, and `\u` / `\U` uppercase the next character / the rest.

**Search across files:** `:vimgrep /pat/ **/*.py`, then `:copen` to see results and `:cnext` / `:cprev` to step through them.

---

## 8. Registers and the macOS clipboard

| Keys | Action |
|---|---|
| `"ay` / `"ap` | yank into / paste from register `a` |
| `"Ay` | *append* to register `a` |
| `"0p` | paste the last **yank** (it isn't overwritten by deletes) |
| `"+y` / `"+p` | copy to / paste from the **system clipboard** |
| `"_d` | delete into the black hole (keeps your clipboard intact) |
| `:reg` | show every register |
| `".` / `":` / `"/` | last inserted text / last command / last search |

> Classic gotcha: you yank a line, then delete another one, and `p` pastes the *deleted* text. Use `"0p`.

To make plain `y` and `p` use the macOS clipboard every time, put `set clipboard=unnamed` in `~/.vimrc`.

---

## 9. Macros

| Keys | Action |
|---|---|
| `qa` … `q` | record into register `a` |
| `@a` | play it |
| `@@` | replay the last macro |
| `10@a` | play it 10 times (it stops early on the first failure) |
| `:'<,'>norm @a` | run it on every selected line |

**Write macros that work anywhere:** start with `0` or `^` so the line position is fixed, use motions like `w f t` instead of arrow-key counting, and end on `j` so the next run starts on the next line.

---

## 10. Files, buffers, windows and tabs

**Buffers** (open files):
`:e path` open · `:ls` list · `:b name` (tab-completes) switch · `:bn` / `:bp` next / previous · `:bd` close · `Ctrl-^` toggle between the last two files.

**Windows** (splits):

| Keys | Action |
|---|---|
| `:sp` / `:vs [file]` | horizontal / vertical split |
| `Ctrl-w h/j/k/l` | move between windows |
| `Ctrl-w w` | cycle through windows |
| `Ctrl-w q` / `Ctrl-w o` | close this window / close all others |
| `Ctrl-w =` | make all windows equal size |
| `Ctrl-w _` / `Ctrl-w \|` | maximise height / width |

**Tabs** are *layouts of windows*, not files: `:tabnew [file]` · `gt` / `gT` next / previous · `:tabc` close.

**File browsing:** `:Ex` (netrw) · `gf` opens the file path under the cursor · `:find name` (works well with `set path+=**`).

---

## 11. Marks and the jump list

| Keys | Action |
|---|---|
| `ma` | set mark `a` (local to the file) |
| `mA` | set mark `A` (global: works across files) |
| `` `a `` / `'a` | jump to the exact position / the line of mark `a` |
| ``` `` ``` | jump back to where you were before the last jump |
| `` `. `` | the position of the last change |
| `gi` | go back to the last insert position and enter Insert mode |
| `Ctrl-o` / `Ctrl-i` | step back / forward through the jump list (works across files) |
| `g;` / `g,` | step back / forward through the change list |

---

## 12. Command-line power

| Command | Effect |
|---|---|
| `:g/pat/d` | delete every line matching `pat` |
| `:v/pat/d` (= `:g!`) | delete every line **not** matching |
| `:g/TODO/norm A !` | run Normal-mode keys on every match |
| `:%norm A;` | add `;` to the end of every line |
| `:sort` / `:sort u` / `:sort n` | sort lines / sort and remove duplicates / sort numerically |
| `:r file` / `:r !cmd` | insert a file / the output of a command |
| `:!cmd` | run a shell command |
| `:%!jq .` | filter the whole buffer through a command (here: pretty-print JSON) |
| `:'<,'>!sort` | filter just the selection |
| `:w !sudo tee %` | save a file you opened without permission |
| `:earlier 5m` / `:later 5m` | time-travel undo |
| `q:` | browse command history in an editable window |

**Ranges:** `.` current line · `$` last line · `%` whole file · `.,+5` this line and the next 5 · `'a,'b` from mark to mark · `/start/,/end/` between two patterns.

---

## 13. Folds, spelling and other bits

- **Folds:** `zf{motion}` create · `za` toggle · `zo` / `zc` open / close · `zR` / `zM` open / close all · `:set foldmethod=indent`
- **Spelling:** `:set spell` · `]s` / `[s` next / previous error · `z=` suggestions · `zg` add the word to the dictionary
- **Formatting:** `gg=G` re-indent the whole file · `gqip` wrap the paragraph
- **Diffs:** `vimdiff a b` · `]c` / `[c` next / previous change · `do` / `dp` get / put the change

---

## 14. Starter `~/.vimrc`

There's no `~/.vimrc` on this Mac yet. This is a sensible starting point, using no plugins:

```vim
" --- basics ---
set nocompatible
syntax on
filetype plugin indent on
set encoding=utf-8
set hidden                 " switch buffers without saving first
set mouse=a
set clipboard=unnamed      " y/p use the macOS clipboard
set backspace=indent,eol,start

" --- ui ---
set number relativenumber  " relative numbers make 5j / 3dk easy
set cursorline
set scrolloff=8
set signcolumn=yes
set showcmd
set wildmenu wildmode=longest:full,full
set laststatus=2
set splitright splitbelow

" --- search ---
set incsearch hlsearch
set ignorecase smartcase   " case-insensitive unless you type a capital

" --- indentation ---
set expandtab tabstop=4 shiftwidth=4 softtabstop=4
set autoindent smartindent

" --- files ---
set path+=**               " :find searches subfolders
set undofile undodir=~/.vim/undo//   " undo history survives restarts
set noswapfile

" --- keys ---
let mapleader = " "
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <Esc><Esc> :noh<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" move the selection down / up
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" stay in Visual mode after indenting
vnoremap < <gv
vnoremap > >gv
```

Run `mkdir -p ~/.vim/undo` once so `undofile` has somewhere to write.

---

## 15. How to actually get good

1. **Week 1:** `vimtutor`, then use only sections 0 to 5 of this guide. Use `hjkl` instead of the arrow keys.
2. **Week 2:** text objects (`ciw`, `ci"`, `da(`) and `f` / `t` with `;`. Stop pressing `w` ten times.
3. **Week 3:** the dot command, `*` with `cgn` (change the next match, then just `.` repeatedly), and macros.
4. **Then:** `:g`, `:norm`, registers and the jump list.

**Habits to break:**
- Pressing `jjjjjj` or `wwwww`: use counts (`6j`), `f{c}`, `}` or `/search` instead.
- Going into Visual mode just to delete: `d` with a text object is faster and can be repeated with `.`.
- Moving around in Insert mode: `Esc` first, then move.
- Using `x` many times: use `dw`, `dt{c}` or `ciw` instead.

**Want an IDE-like setup later?** Look at [Neovim](https://neovim.io) (`brew install neovim`) with [LazyVim](https://www.lazyvim.org). It adds file search, LSP, autocompletion and git. Everything in this guide still applies.
