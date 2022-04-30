'' examples/manual/proguide/emulation_polymorphism-animal.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OBJECT built-in and RTTI info'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgObjectRtti
'' --------

' Emulation of polymorphism is very close to the real operating:
' - a non static pointer is allocated for any derived-type instance to emulate the vptr
'   (its value will depend on what derived-type is constructed: address of the following table)
' - a static procedure pointer table is defined for each derived type to emulate the vtable
'   (an instance reference is passed as first parameter to each static procedure to emulate the hidden 'This' reference passed to any non-static member procedure)


'Base-type animal:
	Type animal
		Protected:
			Dim As Any Ptr Ptr callback_ptr
		Public:
			Declare Function addr_callback_fct () As animal Ptr
			Declare Function speak_callback_fct () As String
			Declare Sub type_callback_sub ()
	End Type

	Function animal.addr_callback_fct () As animal Ptr
		Return CPtr(Function (ByRef As animal) As animal Ptr, This.callback_ptr[0])(This)
	End Function
	Function animal.speak_callback_fct () As String
		Return CPtr(Function (ByRef As animal) As String, This.callback_ptr[1])(This)
	End Function
	Sub animal.type_callback_sub ()
		CPtr(Sub (ByRef As animal), This.callback_ptr[2])(This)
	End Sub

'Derived-type dog:
	Type dog Extends animal
		Private:
			Static As Any Ptr callback_table(0 To 2)
		Public:
			Declare Static Function addr_callback_fct (ByRef As dog) As animal Ptr
			Declare Static Function speak_callback_fct (ByRef As dog) As String
			Declare Static Sub type_callback_sub (ByRef As dog)
			Declare Constructor ()
		Private:
			Dim As String animal_type = "dog"
	End Type
	Static As Any Ptr dog.callback_table(0 To 2) = {@dog.addr_callback_fct, @dog.speak_callback_fct, @dog.type_callback_sub}

'callback_sub methods + constructor for dog object:
	Static Function dog.addr_callback_fct (ByRef d As dog) As animal Ptr
		Return @d
	End Function
	Static Function dog.speak_callback_fct (ByRef d As dog) As String
		Return "Woof!"
	End Function
	Static Sub dog.type_callback_sub (ByRef d As dog)
		Print d.animal_type
	End Sub
	Constructor dog ()
		This.callback_ptr = @callback_table(0)
	End Constructor

'Derived-type cat:
	Type cat Extends animal
		Private:
			Static As Any Ptr callback_table(0 To 2)
		Public:
			Declare Static Function addr_callback_fct (ByRef As cat) As animal Ptr
			Declare Static Function speak_callback_fct (ByRef As cat) As String
			Declare Static Sub type_callback_sub (ByRef As cat)
			Declare Constructor ()
		Private:
			Dim As String animal_type = "cat"
	End Type
	Static As Any Ptr cat.callback_table(0 To 2) = {@cat.addr_callback_fct, @cat.speak_callback_fct, @cat.type_callback_sub}

'callback_sub mehods + constructor for cat object:
	Static Function cat.addr_callback_fct (ByRef c As cat) As animal Ptr
		Return @c
	End Function
	Static Function cat.speak_callback_fct (ByRef c As cat) As String
		Return "Meow!"
	End Function
	Static Sub cat.type_callback_sub (ByRef c As cat)
		Print c.animal_type
	End Sub
	Constructor cat ()
		This.callback_ptr = @callback_table(0)
	End Constructor

'Derived-type bird:
	Type bird Extends animal
		Private:
			Static As Any Ptr callback_table(0 To 2)
		Public:
			Declare Static Function addr_callback_fct (ByRef As bird) As animal Ptr
			Declare Static Function speak_callback_fct (ByRef As bird) As String
			Declare Static Sub type_callback_sub (ByRef As bird)
			Declare Constructor ()
		Private:
			Dim As String animal_type = "bird"
	End Type
	Static As Any Ptr bird.callback_table(0 To 2) = {@bird.addr_callback_fct, @bird.speak_callback_fct, @bird.type_callback_sub}

'callback_sub mehods + constructor for bird object:
	Static Function bird.addr_callback_fct (ByRef b As bird) As animal Ptr
		Return @b
	End Function
	Static Function bird.speak_callback_fct (ByRef b As bird) As String
		Return "Cheep!"
	End Function
	Static Sub bird.type_callback_sub (ByRef b As bird)
		Print b.animal_type
	End Sub
	Constructor bird ()
		This.callback_ptr = @callback_table(0)
	End Constructor

'Create a dog and cat and bird dynamic instances referred through an animal pointer list:
	Dim As dog Ptr p_my_dog = New dog
	Dim As cat Ptr p_my_cat = New cat
	Dim As bird Ptr p_my_bird = New bird
	Dim As animal Ptr animal_list (1 To ...) = {p_my_dog, p_my_cat, p_my_bird}

'Have the animals speak and eat:
	Print "SUB-TYPE POLYMORPHISM", "@object", "speak", "type"
	Print "   by emulation"
	For I As Integer = LBound(animal_list) To UBound(animal_list)
		Print "      animal #" & I & ":",
		Print animal_list(I)->addr_callback_fct(),   'emulated polymorphism
		Print animal_list(I)->speak_callback_fct(),  'emulated polymorphism
		animal_list(I)->type_callback_sub()          'emulated polymorphism
	Next I

Sleep

Delete p_my_dog
Delete p_my_cat
Delete p_my_bird
				
