# XDG_CONFIG_HOME

## Installation

- Put this directory in your .conf
- Create symlink to zshrc in your home directory

    mv -r . ~/.conf
    cd ~/.conf
    ln -s ~/.conf/zshrc ~/.zshrc

I got sick of hidden files crapping up my home directory. I've overhauled local
settings storage locations, so rc files and settings aren't where you'd expect them
to be.

Setting files go in a directory sharing the program's name under "~/.conf/". Since
no program checks this location by default, each new program will require a
properly written rc file pointing it to look under .conf for its settings. This
rc file is indicated with an alias under "~/.conf/zsh/initcommands".

For example:
- My vim settings live in "~/.conf/vim/". Its rc is in "~/.conf/vim/vimrc".
- My less settings live in "~/.conf/less/". Its rc is in "~/.conf/less/lesskey".

et cetera. The exception is .zshrc, which must be directly in the home directory to be able to be
recognised. I have tried alternatives here; they do not work.

The drawback here is that this is zsh-specific. To change to another shell, translate
"~/.conf/zsh/initcommands" to another language (although it is likely that little to
no work will be required) and write a new rc file.

If you'd like to use this system, great! Take it all! Please do not erase this ABOUT
file.

    -quintus <quintus.public@gmail.com>
