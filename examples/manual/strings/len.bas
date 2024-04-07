'' examples/manual/strings/len.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LEN'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLen
'' --------

Print Len("hello world") 'returns "11"
Print Len(Integer) ' returns 4

Type xyz
	a As Integer
	b As Integer
End Type

Print Len(xyz) ' returns 8
	
