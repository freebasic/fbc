'' examples/manual/variable/byref3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BYREF (variables)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByrefVariables
'' --------

'' It is possible to reassign a reference.
'' An example with an UDT to control the successive constructions & destructions of objects handled with one only reference.


Type UDT
  Declare Constructor ()
  Declare Destructor ()
  Dim As Integer I
End Type

Constructor UDT ()
  Static As Integer nb
  nb += 1
  This.I = nb
  Print "UDT.Constructor()"
End Constructor

Destructor UDT ()
  Print "UDT.Destructor()"
End Destructor


Var ByRef ru = *New UDT  '' or Dim Byref As UDT ru = *New UDT
Print ru.I
Delete @ru

Print

@ru = New UDT
Print ru.I
Delete @ru

Sleep
	
