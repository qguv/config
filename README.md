# Quint's Dotfiles

The goal here is to package all the dotfiles in such a way as to respect XDG's
environment variables, especially `XDG_CONFIG_HOME`.

## Installation

- Put this directory in your home folder
- Change zshrc and bashrc (in the top-level) to match the location of this
  directory (default ~/.config)
- Create symlinks for the shells you use based on the location of this
  directory

```
ln -s ~/.config/zshrc ~/.zshrc
ln -s ~/.config/bashrc ~/.bashrc
```

I owe much thanks to woegjiub for all their [bash XDG overrides][1].

Please feel free to use this for your own purposes.

[1]: https://github.com/woegjiub/.config/blob/d32792eb98a3003177318153f836fc4ad62e8ecf/bash/xdg.sh
