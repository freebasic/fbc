'' examples/manual/proguide/udt/ctordtor-parentchild2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constructors, '=' Assignment-Operators, and Destructors (advanced, part #2)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCtorsAssignDtors2
'' --------

Type Parent
	Public:
		Dim As Integer I
	Protected:
		Declare Constructor ()
	Private:
		Declare Constructor (ByRef p As Parent)
End Type

Constructor Parent
End Constructor

Type Child Extends Parent
	Public:
		Dim As Integer J
End Type

Dim As Child c1
Dim As Child C2 = c1
c2 = c1

'Dim As Parent p1                        '' forbidden
'Dim As Parent p2 = c1                   '' forbidden
'Dim As Parent Ptr pp1 = New Parent      '' forbidden
'Dim As Parent Ptr pp2 = New Parent(c1)  '' forbidden

Sleep
			
