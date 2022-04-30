'' examples/manual/switches/option-dynamic.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPTION DYNAMIC'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptiondynamic
'' --------

'' Compile with "-lang fblite" compiler switch

#lang "fblite"

Dim foo(99) As Integer      ' declares a fixed-length array

Option Dynamic

Dim bar(99) As Integer      ' declares a variable-length array
' ...
ReDim bar(199)              ' resize the array
