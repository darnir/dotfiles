" Vim syntax file
" Language:		configure.in script: M4 with sh
" Maintainer:	Christian Hammesr <ch@lathspell.westend.com>
" Last Change:	2013 May 10

" Well, I actually even do not know much about m4. This explains why there
" is probably very much missing here, yet !
" But I missed a good highlighting when editing my GNU autoconf/automake
" script, so I wrote this quick and dirty patch.
" YIL edit 2013: detect AC_MSG strings

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" define the config syntax
syn match   configdelimiter "[()\[\];,]"
syn match   configoperator  "[=|&\*\+\<\>]"
syn match   configcomment   "\(dnl.*\)\|\(#.*\)"
syn match   configfunction  "\<[A-Z_][A-Z0-9_]*\>"
syn match   confignumber    "[-+]\=\<\d\+\(\.\d*\)\=\>"
syn keyword configkeyword   if then else fi test for in do done
syn keyword configspecial   cat rm eval
" This shortens the script, see syn-ext-match..
syn region configstring start=+\z(["'`]\)+ skip=+\\\z1+ end=+\z1+
" Anything inside AC_MSG_TYPE([...]) is a string
" I was expecting ms,me to work, but no
syn region configstring matchgroup=configfunction start="AC_MSG_[A-Z]*" matchgroup=configdelimiter end="\])" contains=configdelimiter
syn region configstring matchgroup=configfunction start="AC_DEFINE" matchgroup=configdelimiter end="\])" contains=configdelimiter

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_config_syntax_inits")
  if version < 508
    let did_config_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink configdelimiter Delimiter
  HiLink configoperator  Operator
  HiLink configcomment   Comment
  HiLink configfunction  Function
  HiLink confignumber    Number
  HiLink configkeyword   Keyword
  HiLink configspecial   Special
  HiLink configstring    String

  delcommand HiLink
endif

let b:current_syntax = "config"

" vim: ts=4
