Shell completion for the FreeBASIC compiler (fbc)

Files
-----
  fbc.bash   Bash completion
  _fbc       Zsh completion
  fbc.fish   Fish completion

Installation
------------

Bash:
  System-wide:
    sudo cp fbc.bash /etc/bash_completion.d/fbc

  Per-user:
    mkdir -p ~/.local/share/bash-completion/completions
    cp fbc.bash ~/.local/share/bash-completion/completions/fbc

  Or source it directly in ~/.bashrc:
    source /path/to/fbc.bash

Zsh:
  Add a directory to $fpath in ~/.zshrc, then copy the file there:
    mkdir -p ~/.zsh/completions
    cp _fbc ~/.zsh/completions/
    # In ~/.zshrc, before compinit:
    fpath=(~/.zsh/completions $fpath)
    autoload -Uz compinit && compinit

  System-wide:
    sudo cp _fbc /usr/share/zsh/site-functions/

Fish:
  Per-user:
    cp fbc.fish ~/.config/fish/completions/

  System-wide:
    sudo cp fbc.fish /usr/share/fish/completions/

Completions provided
--------------------
  Options with fixed value sets: -arch, -asm, -gen, -lang, -forcelang,
    -fpmode, -fpu, -O, -vec, -s, -w, -print, -z
  Options with file/directory completion: -a, -b, -i, -include, -m,
    -map, -o, -p, -prefix, -x
  Source file completion for positional arguments: *.bas, *.a, *.o,
    *.rc, *.res, *.xpm
