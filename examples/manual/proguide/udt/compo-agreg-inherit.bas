'' examples/manual/proguide/udt/compo-agreg-inherit.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Composition, Aggregation, Inheritance'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCompoAggregInherit
'' --------

' Between the different types "Driver", "Person", "Driver_license" and "Vehicle", the respective relationships are:
'    - A driver “IS-A” person (driver is a person): => "INHERITANCE".
'    - A driver “HAS-A” driver's license (driver license only existing for the driver): => "COMPOSITION".
'    - A driver “USES-A” vehicle (vehicle lifetime independent of the driver life): => "AGGREGATION".


Type Person
	Public:
		Dim As String full_name
		Declare Constructor (ByRef _full_name As String)
	Protected:  '' to forbid at compile time the default-construction attempt of a Person instance
		Declare Constructor ()
End Type
Constructor Person (ByRef _full_name As String)
	This.full_name = _full_name
End Constructor

Type Driver_license
	Public:
		Dim As Integer number
End Type

Type Vehicle
	Public:
		Dim As String registration
		Declare Constructor (ByRef _registration As String)
End Type
Constructor Vehicle (ByRef _registration As String)
	This.registration = _registration
End Constructor

Type Driver Extends Person        '' inheritance
	Public:
		Dim As Driver_license dl  '' composition
		Dim As Vehicle Ptr pv     '' aggregation
		Declare Constructor (ByRef _full_name As String, ByRef _dl As Driver_license)
End Type
Constructor Driver (ByRef _full_name As String, ByRef _dl As Driver_license)
	Base(_full_name)
	This.dl = _dl
End Constructor


Dim As Driver d1 = Driver("User fxm", Type<Driver_license>(123456789))

Dim As Vehicle Ptr pv1 = New Vehicle("ABCDEFGHI")
d1.pv = pv1

Print "Person full name      : " & d1.full_name
Print "Driver license number : " & d1.dl.number
Print "Vehicle registration  : " & d1.pv->registration

Delete pv1
d1.pv = 0

Sleep
		
