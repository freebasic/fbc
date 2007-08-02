'' examples/manual/misc/offsetof.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOffsetof
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
