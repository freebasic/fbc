'' examples/manual/strings/len.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLen
'' --------

Print Len("hello world") 'returns "11"
Print Len(Integer) ' returns 4

Type xyz
	a As Integer
	b As Integer
End Type

Print Len(xyz) ' returns 8
