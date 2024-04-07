'' examples/manual/defines/line.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__LINE__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdline
'' --------

Dim a As Integer

If a < 0 Then 
	Print "Error: a = " & a & " in " & __FILE__ & " (" & __FUNCTION__ & ") line " & __LINE__
End If
