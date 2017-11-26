'' examples/manual/defines/date_iso.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDddateiso
'' --------

Print "Compile Date: " & __DATE_ISO__

If __DATE_ISO__ < "2011-12-25" Then
	Print "Compiled before Christmas day 2011"
Else
	Print "Compiled after Christmas day 2011"
End If
