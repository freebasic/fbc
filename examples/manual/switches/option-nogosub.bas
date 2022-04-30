'' examples/manual/switches/option-nogosub.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPTION NOGOSUB'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionnogosub
'' --------

'' Compile with the "-lang qb" compiler switch

'$lang: "qb"

'' turn off gosub support
Option nogosub

Function foo() As Integer
	Return 1234
End Function

Print foo
