'' examples/manual/proguide/real_polymorphism-animal.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OBJECT built-in and RTTI info'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgObjectRtti
'' --------

'Base-type animal:
	Type animal Extends Object
		Public:
			Declare Abstract Function addr_override_fct () As animal Ptr
			Declare Abstract Function speak_override_fct () As String
			Declare Abstract Sub type_override_sub ()
	End Type

'Derived-type dog:
	Type dog Extends animal
		Public:
			Declare Virtual Function addr_override_fct () As animal Ptr Override
			Declare Virtual Function speak_override_fct () As String Override
			Declare Virtual Sub type_override_sub () Override
		Private:
			Dim As String animal_type = "dog"
	End Type
	
	'override_sub procedures for dog object:
		Virtual Function dog.addr_override_fct () As animal Ptr
			Return @This
		End Function
		Virtual Function dog.speak_override_fct () As String
			Return "Woof!"
		End Function
		Virtual Sub dog.type_override_sub ()
			Print This.animal_type
		End Sub

'Derived-type cat:
	Type cat Extends animal
		Public:
			Declare Virtual Function addr_override_fct () As animal Ptr Override
			Declare Virtual Function speak_override_fct () As String Override
			Declare Virtual Sub type_override_sub () Override
		Private:
			Dim As String animal_type = "cat"
	End Type
   
	'override_sub mehods for cat object:
		Virtual Function cat.addr_override_fct () As animal Ptr
			Return @This
		End Function
		Virtual Function cat.speak_override_fct () As String
			Return "Meow!"
		End Function
		Virtual Sub cat.type_override_sub ()
			Print This.animal_type
		End Sub

'Derived-type bird:
	Type bird Extends animal
		Public:
			Declare Virtual Function addr_override_fct () As animal Ptr Override
			Declare Virtual Function speak_override_fct () As String Override
			Declare Virtual Sub type_override_sub () Override
		Private:
			Dim As String animal_type = "bird"
	End Type
   
	'override_sub mehods for bird object:
		Virtual Function bird.addr_override_fct () As animal Ptr
			Return @This
		End Function
		Virtual Function bird.speak_override_fct () As String
			Return "Cheep!"
		End Function
		Virtual Sub bird.type_override_sub ()
			Print This.animal_type
		End Sub

'Create a dog and cat and bird dynamic instances referred through an animal pointer list:
	Dim As dog Ptr p_my_dog = New dog
	Dim As cat Ptr p_my_cat = New cat
	Dim As bird Ptr p_my_bird = New bird
	Dim As animal Ptr animal_list (1 To ...) = {p_my_dog, p_my_cat, p_my_bird}

'Have the animals speak and eat:
	Print "INHERITANCE POLYMORPHISM", "@object", "speak", "type"
	Print "   true operating"
	For I As Integer = LBound(animal_list) To UBound(animal_list)
		Print "      animal #" & I & ":",
		Print animal_list(I)->addr_override_fct(),   'real polymorphism
		Print animal_list(I)->speak_override_fct(),  'real polymorphism
		animal_list(I)->type_override_sub()          'real polymorphism
	Next I

Sleep

Delete p_my_dog
Delete p_my_cat
Delete p_my_bird
				
