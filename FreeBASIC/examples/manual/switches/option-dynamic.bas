'' examples/manual/switches/option-dynamic.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptiondynamic
'' --------

'' Compile with "-lang fblite" compiler switch

#lang "fblite"

Dim foo(99) As Integer      ' declares a fixed-length array

Option Dynamic

Dim bar(99) As Integer      ' declares a variable-length array
' ...
ReDim bar(199) As Integer   ' resize the array
