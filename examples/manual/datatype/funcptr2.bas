'' examples/manual/datatype/funcptr2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FUNCTION Pointer'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFunctionPtr
'' --------

Function x2 (ByVal i As Integer) As Integer
  Return i * 2
End Function

Function x3 (ByVal i As Integer) As Integer
  Return i * 3
End Function

Function operation (ByVal i As Integer, ByVal op As Function (ByVal As Integer) As Integer) As Integer
  Return op(i)
End Function

Print operation(4, @x2)
Print operation(4, @x3)
