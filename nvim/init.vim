call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')

" generic bundles
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'yaifa.vim' " automatic indentation

" external tool interfaces
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'     " ctags
Plug 'rizzatti/dash.vim'     " Dash.app (mac-only)
Plug 'keith/investigate.vim' " better 'K' key

" languages
Plug 'jelera/vim-javascript-syntax'
Plug 'kchmck/vim-coffee-script'
Plug 'fatih/vim-go'
Plug 'wting/rust.vim'
Plug 'dag/vim2hs'
Plug 'tpope/vim-markdown'
Plug 'ingydotnet/yaml-vim'
Plug 'lepture/vim-jinja'

call plug#end()


" appearance
colo elflord
set relativenumber
set number
set ruler
set showcmd

" POSIX line endings
set fileformat=unix

" default indentation behavior
set tabstop=2
set shiftwidth=2
set expandtab

" switch and case statements on the same indent level
set cinoptions=:0

" use one space between sentences when J or gq is used
set nojoinspaces

" better filename completion in command-line
set wildmenu

" disable Ex mode; who needs this anyway?
map Q <Nop>

" toggle paste mode with \p
nmap <Leader>p :set paste! paste?<CR>

" disable auto-indentation with \i
nnoremap <Leader>i :setl noai nocin nosi inde=<CR>

" arrow keys switch between split windows
" (and shifted versions move those windows around)
" they don't do anything else anyway
nnoremap <silent> <Right>   :wincmd l<CR>
nnoremap <silent> <Left>    :wincmd h<CR>
nnoremap <silent> <Up>      :wincmd k<CR>
nnoremap <silent> <Down>    :wincmd j<CR>
nnoremap <silent> <S-Right> :wincmd L<CR>
nnoremap <silent> <S-Left>  :wincmd H<CR>
nnoremap <silent> <S-Up>    :wincmd K<CR>
nnoremap <silent> <S-Down>  :wincmd J<CR>

" Tag-bar for ctags
nnoremap <silent> <F9> :TagbarToggle<CR>

" Nerdtree
map <F10> :NERDTreeToggle<CR>

" text documents should have linebreaks, since newlines imply paragraphs
autocmd BufNewFile,BufRead {*.tex,*.md,*.txt} set linebreak

" vim-clutch is the epitome of over-engineering
nnoremap <silent> <F6> i
inoremap <silent> <F6> <Nop>

" [w/W]indowify: push current tab into previous window
nnoremap <Leader>w :call MoveToNextTab()<CR>
nnoremap <Leader>W :call MoveToPrevTab()<CR>
function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
