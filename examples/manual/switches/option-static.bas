'' examples/manual/switches/option-static.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPTION STATIC'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionstatic
'' --------

'' Compile with the "-lang fblite" compiler switch

#lang "fblite"

Option Dynamic

Dim foo(100) As Integer			' declares a variable-length array

Option Static

Dim bar(100) As Integer			' declares a fixed-length array
