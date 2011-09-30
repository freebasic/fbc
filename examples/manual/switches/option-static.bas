'' examples/manual/switches/option-static.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionstatic
'' --------

'' Compile with the "-lang fblite" compiler switch

#lang "fblite"

Option Dynamic

Dim foo(100) As Integer			' declares a variable-length array

Option Static

Dim bar(100) As Integer			' declares a fixed-length array
