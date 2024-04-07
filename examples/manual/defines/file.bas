'' examples/manual/defines/file.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FILE__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfile
'' --------

Dim a As Integer
If a<0 Then
	Print "Error: a = " & a & " in " & __FILE__ & " (" & __FUNCTION__ & ") line " & __LINE__
End If
