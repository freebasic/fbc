'' examples/manual/defines/date_iso.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__DATE_ISO__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDddateiso
'' --------

Print "Compile Date: " & __DATE_ISO__

If __DATE_ISO__ < "2011-12-25" Then
	Print "Compiled before Christmas day 2011"
Else
	Print "Compiled after Christmas day 2011"
End If
