'' examples/manual/misc/as.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'AS'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAs
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
