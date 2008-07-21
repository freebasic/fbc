'' examples/manual/switches/option-gosub.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptiongosub
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
