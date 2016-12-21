" load plugin config shared with vim
let nvimdir=substitute(system('echo "$XDG_CONFIG_HOME"'),'\n','','').'/nvim'
call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
exec ':so ' . nvimdir . '/plugrc.vim'
call plug#end()

" load settings shared with vim
exec ':so ' . nvimdir . '/settings.vim'
