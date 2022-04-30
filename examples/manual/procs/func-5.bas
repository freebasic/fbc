'' examples/manual/procs/func-5.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FUNCTION'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFunction
'' --------

'' This example shows how to declare and call 
'' functions taking array arguments.

Function x(b() As Double) As Integer
  x = UBound(b)-LBound(b)+1
End Function

Dim a(1 To 10) As Double
Print x(a())
Dim c(10 To 20) As Double 
Print x(c())
