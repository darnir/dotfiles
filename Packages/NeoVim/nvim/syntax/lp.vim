" Vim Syntax File
"
" Language:    OPL
" Maintainers: Prause
" Created:     May 01 2011

if version < 600
   syn clear
elseif exists("b:current_syntax")
  finish
endif

syntax case match
syn sync minlines=50

syntax keyword oplModelKeyword     minimize sum abs subject to forall execute for new in

syntax keyword oplType             int float dvar var boolean range string


syntax region  oplRegionComment    fold start=/\/\*/ end=/\*\// contains=oplTODO
syntax match   oplLineComment      "//.*" contains=oplTODO ",@Spell
syntax keyword oplTODO             FIXME TODO fixme todo Fixme FixMe Todo ToDo XXX xxx contained

syntax match   oplNumber           /\<\d\+\>/
syntax match   oplNumber           /\<\d\+\.\d\+\>/
syntax match   oplNumber           /\<\d\+\.\d\+e-\d\+\>/

syntax match   oplConstraint       "\<[a-zA-Z][_$a-zA-Z0-9]*:" skipwhite
syntax match   oplConstant         "\<[A-Z]\+\>"

"""" Highlights

highlight link oplRegionComment    Comment
highlight link oplLineComment      Comment
highlight link oplTODO             TODO

highlight link oplConstant         Constant
highlight link oplType             Type
highlight link oplNumber           Number
highlight link oplConstraint       Identifier

highlight link oplModelKeyword     Keyword

let b:current_syntax = "opl"
