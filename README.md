# Quint's Dotfiles

This repository contains configuration files for my shell and all other (mostly
command-line) utilities I've customized. Feel free to dig through and copy
customizations that you like, or use the entire project wholesale.

The goal here is to package all the dotfiles in such a way as to respect XDG's
environment variables, especially `XDG_CONFIG_HOME`.

## Installation

If you have an existing `~/.config` directory, you should move it out of the
way. Same goes for `~/.bashrc` and `~/.zshrc`. This may also be a good time to
inspect other shell startup files: `~/.profile`, `~/.bash_profile`, etc, to see
if they're still necessary, although these will not be overwritten.

```
git clone https://github.com/qguv/config ~/.config
ln -s ~/.config/shellrc ~/.zshrc
ln -s ~/.config/shellrc ~/.bashrc
ln -s ~/.config/pam_environment ~/.pam_environment
```

Once installed, you can place system-specific customizations in
`~/.config/bash/system`.

## Credits

I owe much thanks to woegjiub for all their [bash XDG overrides][] and ayekat
for the [list of remaining delinquent projects][].

I've pulled many configurations from others. They are attributed as comments
where possible.

[bash XDG overrides]: https://github.com/woegjiub/.config/blob/d32792eb98a3003177318153f836fc4ad62e8ecf/bash/xdg.sh
[list of remaining delinquent projects]: https://github.com/ayekat/dotfiles/issues/7
