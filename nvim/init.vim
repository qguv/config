call plug#begin('~/.vim/plugged')

" generic bundles
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'yaifa.vim' " automatic indentation

" color schemes
Plug 'altercation/vim-colors-solarized'

" external tool interfaces
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'  " ctags
Plug 'rizzatti/dash.vim'  " Dash.app (mac-only)

" languages
Plug 'jelera/vim-javascript-syntax'
Plug 'kchmck/vim-coffee-script'
Plug 'fatih/vim-go'
Plug 'wting/rust.vim'
Plug 'dag/vim2hs'
Plug 'tpope/vim-markdown'
Plug 'ingydotnet/yaml-vim'

call plug#end()

" solarize
colo solarized
set background=dark

" basic settings
set relativenumber
set ruler
set fileformat=unix
set tabstop=2
set shiftwidth=2
set expandtab

" disable Ex mode; who needs this anyway?
map Q <Nop>

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
