'' examples/manual/proguide/real_emulation_polymorphism-animal.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OBJECT built-in and RTTI info'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgObjectRtti
'' --------

' Emulated polymorphism (with explicit callback member procedures)
' and
' True polymorphism (with abstract/virtual member procedures),
' both in an inheritance structure.


'Base-type animal:
	Type animal Extends Object  'Extends Object' useful for true polymorphism only
	' for true polymorphism:
		Public:
			Declare Abstract Function addr_override_fct () As animal Ptr
			Declare Abstract Function speak_override_fct () As String
			Declare Abstract Sub type_override_sub ()
	' for polymorphism emulation:
		Protected:
			Dim As Any Ptr Ptr callback_ptr
		Public:
			Declare Function addr_callback_fct () As animal Ptr
			Declare Function speak_callback_fct () As String
			Declare Sub type_callback_sub ()
	End Type

	' for polymorphism emulation:
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
	' for true polymorphism:
		Public:
			Declare Virtual Function addr_override_fct () As animal Ptr Override
			Declare Virtual Function speak_override_fct () As String Override
			Declare Virtual Sub type_override_sub () Override
	' for polymorphism emulation:
		Private:
			Static As Any Ptr callback_table(0 To 2)
		Public:
			Declare Static Function addr_callback_fct (ByRef As dog) As animal Ptr
			Declare Static Function speak_callback_fct (ByRef As dog) As String
			Declare Static Sub type_callback_sub (ByRef As dog)
			Declare Constructor ()
	' for all:
		Private:
			Dim As String animal_type = "dog"
	End Type

	' for true polymorphism:
		' override_sub methods for dog object:
			Virtual Function dog.addr_override_fct () As animal Ptr
				Return @This
			End Function
			Virtual Function dog.speak_override_fct () As String
				Return "Woof!"
			End Function
			Virtual Sub dog.type_override_sub ()
				Print This.animal_type
			End Sub

	' for polymorphism emulation:
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
	' for true polymorphism:
		Public:
			Declare Virtual Function addr_override_fct () As animal Ptr Override
			Declare Virtual Function speak_override_fct () As String Override
			Declare Virtual Sub type_override_sub () Override
	' for polymorphism emulation:
		Private:
			Static As Any Ptr callback_table(0 To 2)
		Public:
			Declare Static Function addr_callback_fct (ByRef As cat) As animal Ptr
			Declare Static Function speak_callback_fct (ByRef As cat) As String
			Declare Static Sub type_callback_sub (ByRef As cat)
			Declare Constructor ()
	' for all:
		Private:
			Dim As String animal_type = "cat"
	End Type

	' for true polymorphism:
		' override_sub mehods for cat object:
			Virtual Function cat.addr_override_fct () As animal Ptr
				Return @This
			End Function
			Virtual Function cat.speak_override_fct () As String
				Return "Meow!"
			End Function
			Virtual Sub cat.type_override_sub ()
				Print This.animal_type
			End Sub

	' for polymorphism emulation:
		Static As Any Ptr cat.callback_table(0 To 2) = {@cat.addr_callback_fct, @cat.speak_callback_fct, @cat.type_callback_sub}
		' callback_sub mehods + constructor for cat object:
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
	' for true polymorphism:
		Public:
			Declare Virtual Function addr_override_fct () As animal Ptr Override
			Declare Virtual Function speak_override_fct () As String Override
			Declare Virtual Sub type_override_sub () Override
	' for polymorphism emulation:
		Private:
			Static As Any Ptr callback_table(0 To 2)
		Public:
			Declare Static Function addr_callback_fct (ByRef As bird) As animal Ptr
			Declare Static Function speak_callback_fct (ByRef As bird) As String
			Declare Static Sub type_callback_sub (ByRef As bird)
			Declare Constructor ()
	' for all:
		Private:
			Dim As String animal_type = "bird"
	End Type

	' for true polymorphism:
		' override_sub mehods for bird object:
			Virtual Function bird.addr_override_fct () As animal Ptr
				Return @This
			End Function
			Virtual Function bird.speak_override_fct () As String
				Return "Cheep!"
			End Function
			Virtual Sub bird.type_override_sub ()
				Print This.animal_type
			End Sub

	' for polymorphism emulation:
		Static As Any Ptr bird.callback_table(0 To 2) = {@bird.addr_callback_fct, @bird.speak_callback_fct, @bird.type_callback_sub}
		' callback_sub mehods + constructor for bird object:
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
	For I As Integer = LBound(animal_list) To UBound(animal_list)
		Print "   animal #" & I & ":"
		' for override_sub:
			Print "      true operating:",
			Print animal_list(I)->addr_override_fct(),   'real polymorphism
			Print animal_list(I)->speak_override_fct(),  'real polymorphism
			animal_list(I)->type_override_sub()          'real polymorphism
		' for polymorphism emulation:
			Print "      by emulation:",
			Print animal_list(I)->addr_callback_fct(),   'emulated polymorphism
			Print animal_list(I)->speak_callback_fct(),  'emulated polymorphism
			animal_list(I)->type_callback_sub()          'emulated polymorphism
	Next I

Sleep

Delete p_my_dog
Delete p_my_cat
Delete p_my_bird
			
