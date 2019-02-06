set nocompatible

" appearance
colorscheme elflord
set background=dark
set relativenumber number
set ruler
set showcmd
set hlsearch

" case sensitive search iff search string has a capital
set ignorecase smartcase

" prefer prompting to failing when interpreting user commands
set confirm

" POSIX line endings
set fileformat=unix
set fileformats=unix,mac,dos

" default indentation behavior
set tabstop=4
set shiftwidth=4
set expandtab
let g:yaifa_max_lines=500
let g:yaifa_tab_width=8
let g:yaifa_indentation=3

" F4 or F8 retabs against four or eight spaces
nnoremap <silent> <F4> :set softtabstop=0 tabstop=4 shiftwidth=4 noexpandtab cindent cinoptions=(0,u0,U0<CR>:%RetabIndent!<CR>
nnoremap <silent> <F8> :set softtabstop=0 tabstop=8 shiftwidth=8 noexpandtab cindent cinoptions=(0,u0,U0<CR>:%RetabIndent!<CR>

" don't fold unless we ask
set foldmethod=manual nofoldenable

" switch and case statements on the same indent level
set cinoptions=:0

" use one space between sentences when J or gq is used
set nojoinspaces

" conceal settings for unicode lambda replacement etc.
set concealcursor=nc
set conceallevel=1
let g:haskell_conceal_wide=1

" text documents should have linebreaks, since newlines imply paragraphs
autocmd BufNewFile,BufRead {*.tex,*.md,*.txt} set linebreak

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

" toggle paste mode with \p
nmap <Leader>p :set paste! paste?<CR>

" disable auto-indentation with \i
nnoremap <Leader>i :setl noai nocin nosi inde=<CR>

" uncomment lines with \u + comment marker
command! -nargs=1 -bar UncommentLines %g:^<args>::s
nnoremap <Leader>u :UncommentLines<space>

" two-pane reading with \v
noremap <silent> <Leader>v :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" open window as new tab with \t
nnoremap <Leader>t :wincmd T<CR>

" remove consecutive blank lines
command! -nargs=0 -bar FixBlanks %s:\n\{3,}:\r\r:e
nnoremap <Leader>s :FixBlanks<CR>

" push current tab into {previous, next} window with \{w,W}
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

" ctags with F9
nnoremap <silent> <F9> :TagbarToggle<CR>

" Nerdtree with F10
map <F10> :NERDTreeToggle<CR>

" vim-clutch is the epitome of over-engineering
nnoremap <silent> <F6> i
inoremap <silent> <F6> <Nop>

" rainbow parentheses for lisp-like languages
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

" shiftkiller with vk
inoremap vk <C-R>=shiftkiller#Shiftkiller('_')<CR>

" rust racer support
set hidden
let g:racer_cmd = '/usr/bin/racer'
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" enable mouse
set mouse=a

" use the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack
