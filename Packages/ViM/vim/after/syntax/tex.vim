" XXX: Doesn't seem to work. Test and fix
syn match TeXPlaceHolder "<+[A-Za-z0-9]*"
syn region TeXPlaceHolder start=/\v</ end=/\v>/
highlight def link TeXPlaceHolder String
