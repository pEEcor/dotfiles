# Trubbleshooting

## tmux on osx

Symptom:

- Double inserted characters in tmux when accessing osx machine
- Backspace not working

Problem:

- Mac OS does not come with a terminal description for tmux-256colors.

Solution:

- Using screen-256colors solves the issue. But this drops the support for italic
font inside tmux.
- The better solution is to install the missing term info.

```bash
$ brew install ncurses
$ /usr/local/opt/ncurses/bin/infocmp tmux-256color > ~/tmux-256color.info
$ tic -xe tmux-256color tmux-256color.info
# This creates a complied entry in ~/.terminfo
$ infocmp tmux-256color | head
#       Reconstructed via infocmp from file: /Users/libin/.terminfo/74/tmux-256color
tmux-256color|tmux with 256 colors,
```

Long answer: [bbqtd](https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95)
