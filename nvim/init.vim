" load plugin config (shared with vim)
call plug#begin()
exec ':so ' . stdpath('config') . '/plugrc.vim'
call plug#end()

" load settings (shared with vim)
exec ':so ' . stdpath('config') . '/settings.vim'
