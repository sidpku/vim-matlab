" Vim compiler file
" Compiler:         Matlab mlint code checker
" Maintainer:       Fabrice Guy <fabrice.guy at gmail dot com>
" Latest Revision:  2008 Oct 16
" Comment:          mlint messages are either 
"                   - L x (C y): message (where x and y are line number and
"                   column number)
"                   - L x (C y-z): message (where x is the line number, y and
"                   z the column numbers where the error comes from)


if exists("current_compiler")
  finish
endif
let current_compiler = "mlint"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" pipe through sed to prepend filename:
CompilerSet makeprg=mlint\ -id\ %\ \\\|&\ sed\ 's/^/%:/'

" errorformat originally from syntastic
CompilerSet errorformat=
      \%f:L\ %l\ (C\ %c):\ %*[a-zA-Z0-9]:\ %m,
      \%f:L\ %l\ (C\ %c-%*[0-9]):\ %*[a-zA-Z0-9]:\ %m


" mlint doesn't provide filename information except if multiple
" filenames are given 
" With the following command :
" mlint <filename>
" mlint produces an output like that :
" ========== <filename> ==========
" L x (C y): ID : Message
" L x (C y): ID : Message
" ..
"

" CompilerSet errorformat=
"       \%-P==========\ %f\ ==========,
"       \%-G%>==========\ %s\ ==========,
"       \%-G%>L\ %l\ (C\ %c):\ MDOTM%m,
"       \L\ %l\ (C\ %c):\ %m,
"       \L\ %l\ (C\ %c-%*[0-9]):\ %m,
"       \%-Q


