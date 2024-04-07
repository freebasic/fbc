'' examples/manual/meta/include.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '$INCLUDE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMetaInclude
'' --------

'' compile with -lang fblite or qb

#lang "fblite"

'' main.bas file

'$INCLUDE: "header.bi"

Foo.Bar = 1
Foo.Barbeque = 2
