# Handling italics:
1. Create a xterm-256color-italic.terminfo file with these contents:
```
# A xterm-256color based TERMINFO that adds the escape sequences for italic.
xterm-256color-italic|xterm with 256 colors and italic,
  sitm=\E[3m, ritm=\E[23m,
  use=xterm-256color,
```

2. Add the file to the list of terminals:
```
$ tic xterm-256color-italic.terminfo
```




