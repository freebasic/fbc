'' examples/manual/procs/func-5.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFunction
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
