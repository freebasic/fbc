'' examples/manual/misc/as.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAs
'' --------

'' don't try to compile this code, the examples are unrelated
Declare Sub mySub (X As Integer, Y As Single, Z As String)
' ...

Dim X As Integer
' ...

Type myType
  X As Integer
  Y As Single
  Z As String
End Type
' ...

Type TheNewType As myType
' ...

Open "test" For Input As #1
' ...
