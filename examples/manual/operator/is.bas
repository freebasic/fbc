'' examples/manual/operator/is.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpIs
'' --------

Type Vehicle extends object
	As String Name
End Type

Type Car extends Vehicle
End Type

Type Cabriolet extends Car
End Type

Type Bike extends Vehicle
End Type

Sub identify(ByVal p As object Ptr)
	Print "Identifying:"

	'' Not a Vehicle object?
	If Not (*p Is Vehicle) Then
		Print , "unknown object"
		Return
	End If

	'' The cast is safe, because we know it's a Vehicle object
	Print , "name: " & CPtr(Vehicle Ptr, p)->Name

	If *p Is Car Then
		Print , "It's a car"
	End If

	If *p Is Cabriolet Then
		Print , "It's a cabriolet"
	End If

	If *p Is Bike Then
		Print , "It's a bike"
	End If
End Sub

Dim As Car ford
ford.name = "Ford"
identify(@ford)

Dim As Cabriolet porsche
porsche.name = "Porsche"
identify(@porsche)

Dim As Bike mountainbike
mountainbike.name = "Mountain Bike"
identify(@mountainbike)

Dim As Vehicle v
v.name = "some unknown vehicle"
identify(@v)

Dim As Object o
identify(@o)
