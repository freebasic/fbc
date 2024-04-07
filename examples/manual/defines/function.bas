'' examples/manual/defines/function.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FUNCTION__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfunction
'' --------

Dim a As Integer

'...

If a < 0 Then '' this shouldn't happen
	Print "Error: a = " & a & " in " & __FILE__ & " (" & __FUNCTION__ & ") line " & __LINE__
End If
