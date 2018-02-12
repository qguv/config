" load plugin config shared with vim
function! s:envget(cmd)
    return substitute(system('echo "$' . a:cmd . '"'), '\n', '', '')
endfunction

let xdgdir=s:envget('XDG_CONFIG_HOME')
if empty(xdgdir)
    let xdgdir=s:envget('HOME') . '/.config'
endif

let nvimdir=xdgdir . '/nvim'

call plug#begin(nvimdir . '/plugged')
exec ':so ' . nvimdir . '/plugrc.vim'
call plug#end()

" load settings shared with vim
exec ':so ' . nvimdir . '/settings.vim'
