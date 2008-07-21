'' examples/manual/switches/option-nogosub.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionnogosub
'' --------

'' Compile with the "-lang qb" compiler switch

'$lang: "qb"

'' turn off gosub support
Option nogosub

Function foo() As Integer
	Return 1234
End Function

Print foo
