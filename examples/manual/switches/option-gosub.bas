'' examples/manual/switches/option-gosub.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPTION GOSUB'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptiongosub
'' --------

'' Compile with the "-lang fblite" compiler switch

#lang "fblite"

'' turn on gosub support
Option GoSub

GoSub there
backagain:
	Print "backagain"
	End

there:
	Print "there"
	Return
