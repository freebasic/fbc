'' examples/manual/variable/static2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgStatic
'' --------

'Assign an unique ID to every instance of a Type (ID incremented in order of creation)

Type UDT
  Public:
	Declare Property getID () As Integer
	Declare Constructor ()
  Private:
	Dim As Integer ID
	Static As Integer countID
End Type
Dim As Integer UDT.countID = 0

Property UDT.getID () As Integer
  Property = This.ID
End Property

Constructor UDT ()
  This.ID = UDT.countID
  UDT.countID += 1
End Constructor


Dim As UDT uFirst
Dim As UDT uSecond
Dim As UDT uThird

Print uFirst.getID
Print uSecond.getID
Print uThird.getID
