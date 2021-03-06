" shiftkiller.vim: save your pinkies while pressing long variable names
"
" Shiftkiller adds a mode that lets you type a variable name as a sequence of
" words, converting it to snake_case, camelCase, PascalCase, or kebab-case. To
" load unconditionally:
"
"     inoremap vk <C-R>=shiftkiller#Shiftkiller('_')<CR>
"
" Change the '_' to '-' or 'camelCase' or 'PascalCase' as desired. To load for
" some filetypes:
"
"     autocmd BufNewFile,BufRead,VimEnter {*.go,*.hs,*.java} inoremap vk <C-R>=shiftkiller#Shiftkiller('camelCase')<CR>

if exists('g:loaded_shiftkiller')
  finish
endif
let g:loaded_shiftkiller = 1

function CharIsUppercase(charnum)
  "65: A, 90: Z
  return a:charnum >= 65 && a:charnum <= 90
endfunc

function CharIsLowercase(charnum)
  "97: a, 122: z
  return a:charnum >= 97 && a:charnum <= 122
endfunc

function CharIsLetter(charnum)
  return CharIsLowercase(a:charnum) || CharIsUppercase(a:charnum)
endfunc

function CharCapitalize(charnum)
  if CharIsLowercase(a:charnum)
    "97: a, 65: A
    return a:charnum + (65 - 97)
  else
    return a:charnum
  endif
endfunc

" Fancy variable-mode. Allows insertion of camelCase, PascalCase, snake_case, and scheme-style variables
function shiftkiller#Shiftkiller(mode)

  let l:camelcase = (a:mode is "camelCase")

  " Show the variable-mode prompt.
  echo "-- variable --"
  let l:variable = ""

  " Read exactly one character of input.
  let l:inchar = getchar()

  " the spacebar is character 32
  let l:char_space = 32

  while (CharIsLetter(l:inchar) || l:inchar == l:char_space || l:inchar is# "\<BS>")

    " A space was entered. Since double-space gets out of the mode, figure out
    " whether this space is a real variable space or part of a mode-exiting
    " double-space sequence.
    if (l:inchar == l:char_space)

      " camelCase mode appends a caret to the prompt to indicate that the next character will be capitalized.
      if (l:camelcase)
        echo "var: " . l:variable . "^"

      " other mode shows what between-character would be inserted
      else
        echo "var: " . l:variable . a:mode

      endif
      let l:inchar = getchar()

      " we've entered a second space; return the whole thing
      if (l:inchar == l:char_space)
        return l:variable . " "

      " we've backspaced
      elseif (l:inchar is# "\<BS>")
        " but we haven't changed anything so we'll let it slide

      " we've entered a new variable character
      elseif (CharIsLetter(l:inchar))
        if (l:camelcase)
          let l:variable = l:variable . nr2char(CharCapitalize(l:inchar))
        else
          let l:variable = l:variable . a:mode . nr2char(l:inchar)
        endif

      " we've entered a symbol BUT we also owe them a space
      else
        return l:variable . " " . nr2char(l:inchar)

      endif

    " we entered a backspace
    elseif (l:inchar is# "\<BS>")

      if (l:variable is "")
      " nothing to delete
        return ""
      else
        let l:variable = substitute(l:variable, '\(.*\).$', '\1', 'g')
      endif

    " we entered a normal character
    else
      let l:variable = l:variable . nr2char(l:inchar)
    endif

    echo "var: " . l:variable
    let l:inchar = getchar()
  endwhile

  " ended with a symbol
  let l:variable = l:variable . nr2char(l:inchar)

  return l:variable
endfunc
