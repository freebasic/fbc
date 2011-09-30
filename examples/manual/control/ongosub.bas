'' examples/manual/control/ongosub.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOngosub
'' --------

'' Compile with -lang qb

'$lang: "qb"

choice = 3
On choice GoSub labela, labelb, labelc
Print "Good bye."
End

labela:
Print "choice a"
Return

labelb:
Print "choice b"
Return

labelc:
Print "choice c"
Return
