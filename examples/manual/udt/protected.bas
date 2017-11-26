'' examples/manual/udt/protected.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgVisProtected
'' --------

Type animal
  Dim As String animalName
  Protected:
	Dim As Integer serialNumber
End Type

Type dog Extends animal
  Dim As String masterName
  Declare Sub setSerialNumber ( ByVal number As Integer )
End Type

Sub dog.setSerialNumber ( ByVal number As Integer )
  '' This is OK. We're inside a member function of the derived type
  This.serialNumber = number
End Sub

Dim As dog d

'' This is OK, animalName is public
d.animalName = "Buddy"

'' this would generate a compile error: 
'' - serialNumber is protected and we're trying to access it outside its type and the derived type
'' d.serialNumber = 123456789
