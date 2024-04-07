'' examples/manual/misc/offsetof.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OFFSETOF'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOffsetof
'' --------

Type MyType
  x As Single
  y As Single
  Union
	b As Byte
	i As Integer
  End Union
End Type

Print "OffsetOf x = "; OffsetOf(MyType, x)
Print "OffsetOf y = "; OffsetOf(MyType, y)
Print "OffsetOf b = "; OffsetOf(MyType, b)
Print "OffsetOf i = "; OffsetOf(MyType, i)
