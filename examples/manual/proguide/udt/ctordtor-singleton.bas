'' examples/manual/proguide/udt/ctordtor-singleton.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constructors, '=' Assignment-Operators, and Destructors (advanced, part #2)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCtorsAssignDtors2
'' --------

Type Singleton
	Public:
		Declare Static Function create () As Singleton Ptr
		Declare Static Sub suppress ()
		Dim i As Integer
	Private:
		Static As Singleton Ptr ref
		Declare Constructor ()
		Declare Constructor (ByRef rhs As Singleton)
		Declare Destructor ()
End Type

Dim As Singleton Ptr Singleton.ref = 0

Static Function Singleton.create () As Singleton Ptr
	If Singleton.ref = 0 Then
		Singleton.ref = New Singleton
		Return Singleton.ref
	Else
		Return 0
	End If
End Function

Static Sub Singleton.suppress ()
	If Singleton.ref > 0 Then
		Delete Singleton.ref
		Singleton.ref = 0
	End If
End Sub

Constructor Singleton ()
End Constructor

Destructor Singleton ()
End Destructor


Dim As Singleton Ptr ps1 = Singleton.create()
ps1->i = 1234
Print ps1, ps1->i

Dim As Singleton Ptr ps2 = Singleton.create()
Print ps2

Singleton.suppress()

Dim As Singleton Ptr ps3 = Singleton.create()
Print ps3, ps3->i

Singleton.suppress()

'Delete ps3                                      '' forbidden
'Dim As Singleton s1                             '' forbidden
'Dim As Singleton s2 = *ps3                      '' forbidden
'Dim As Singleton Ptr ps4 = New Singleton        '' forbiden
'Dim As Singleton Ptr ps5 = New Singleton(*ps3)  '' forbidden

Sleep
			
