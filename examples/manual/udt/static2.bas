'' examples/manual/udt/static2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'STATIC (Member)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgStaticMember
'' --------

'' Assign an unique ID to every instance of a Type (ID incremented in order of creation)

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
