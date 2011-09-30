'' examples/manual/procs/overload.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOverload
'' --------

Declare Function SUM Overload (A As Integer,B As Integer) As Integer
Declare Function SUM Overload (A As Single,B As Single) As Single
Function SUM  (A As Integer,B As Integer) As Integer
   Function=A+B
End Function   
Function SUM  (A As Single,B As Single) As Single
   Function=A+B
End Function   
Dim As Integer A,B
Dim As Single A1,B1
A=2
B=3
A1=2.
b1=3.
Print SUM(A,B)
Print SUM (A1,B1)
Sleep
