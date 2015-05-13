'' examples/manual/control/iif4.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgIif
'' --------

Type UDT1
  Dim As Integer I1
End Type

Type UDT2 Extends UDT1
  Dim As Integer I2
End Type

Dim As UDT1 u1, u10 = (1)
Dim As UDT2 u2, u20 = (2, 3)

u1 = IIf(0, u10, u20)
Print u1.I1
u1 = IIf(1, u10, u20)
Print u1.I1

u2 = IIf(0 , u10, u20)
Print u2.I1; u2.I2
'u2 = Iif(1, u10, u20) ''Invalid assignment/conversion
Sleep
