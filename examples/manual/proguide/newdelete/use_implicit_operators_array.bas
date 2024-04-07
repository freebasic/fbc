'' examples/manual/proguide/newdelete/use_implicit_operators_array.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Use Implicit / Overload New([]) and Delete([]) Operators with Inheritance Polymorphism'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgUseNewDelete
'' --------

' Code for using implicit 'New[]'/'Delete[]' operators from base-typed pointer array in polymorphic inheritance context
'    Added member procedures to workaround unsuitable or unexpected behaviors:
'       - Abstract/Virtual 'Operator []()' to access to the right address of any derived object from a base-typed pointer
'       - Abstract/Virtual 'DeleteSB_launcher()' to destroy the right objects from a base-typed pointer

Type Animal Extends Object
	Public:
		Declare Abstract Sub Init(ByRef _name As String, ByRef _favorite As String)
		Declare Abstract Function get_attributes() As String
		Declare Virtual Destructor()
		Declare Abstract Operator [](ByVal _n As Integer) ByRef As Animal
		Declare Abstract Sub DeleteSB_launcher()
	Protected:
		Dim As String Name
		Declare Constructor()
	Private:
		Declare Constructor(ByRef _a As Animal)
End Type

Destructor Animal ()
	Print "Animal destructor: ", "object address: " & @This
End Destructor

Constructor Animal ()
	Print "Animal constructor: ", "object address: " & @This
End Constructor


Type Cat Extends Animal
	Public:
		Declare Constructor()
		Declare Virtual Sub Init(ByRef _name As String, ByRef _favorite As String)
		Declare Virtual Function get_attributes() As String
		Declare Virtual Destructor()
		Declare Virtual Operator [](ByVal _n As Integer) ByRef As Cat
		Declare Virtual Sub DeleteSB_launcher()
	Private:
		Dim As String favorite
End Type

Constructor Cat()
	Print "  Cat constructor: ", "  object address: " & @This
End Constructor

Sub Cat.Init(ByRef _name As String, ByRef _favorite As String = "")
	This.Name = _name
	This.favorite = _favorite
End Sub

Function Cat.get_attributes() As String
	Return This.Name & ": Cat, Meow, " & This.favorite
End Function

Destructor Cat()
	Print "  Cat destructor: ", "  object address: " & @This
End Destructor

Operator Cat.[](ByVal _n As Integer) ByRef As Cat
	Return (@This)[_n]
End Operator

Sub Cat.DeleteSB_launcher()
	Delete[] @This
End Sub


Type Dog Extends Animal
	Public:
		Declare Constructor()
		Declare Virtual Sub Init(ByRef _name As String, ByRef _favorite As String)
		Declare Virtual Function get_attributes() As String
		Declare Virtual Destructor()
		Declare Virtual Operator [](ByVal _n As Integer) ByRef As Dog
		Declare Virtual Sub DeleteSB_launcher()
	Private:
		Dim As String favorite
End Type

Constructor Dog()
	Print "  Dog constructor: ", "  object address: " & @This
End Constructor

Sub Dog.Init(ByRef _name As String, ByRef _favorite As String)
	This.Name = _name
	This.favorite = _favorite
End Sub

Function Dog.get_attributes() As String
	Return This.Name & ": Dog, Woof, " & This.favorite
End Function

Destructor Dog()
  Print "  Dog destructor: ", "  object address: " & @This
End Destructor

Operator Dog.[](ByVal _n As Integer) ByRef As Dog
	Return (@This)[_n]
End Operator

Sub Dog.DeleteSB_launcher()
	Delete[] @This
End Sub

'------------------------------------------------------------------------------

Dim As Animal Ptr pa(0 To ...) = {New Cat[2], New Dog[2]}

'pa(0)[0].Init("Tiger", "Salmon")   '' does not work
'pa(0)[1].Init("Kitty", "Sardine")  '' does not work
'pa(1)[0].Init("Buddy", "Lamb")     '' does not work
'pa(1)[1].Init("Molly", "Beef")     '' does not work
(*pa(0))[0].Init("Tiger", "Salmon")
(*pa(0))[1].Init("Kitty", "Sardine")
(*pa(1))[0].Init("Buddy", "Lamb")
(*pa(1))[1].Init("Molly", "Beef")

For I As Integer = LBound(pa) To UBound(pa)
	For J As Integer = 0 To 1
'        Print "    " & pa(I)[J].get_attributes()  '' does not work
		Print "    " & (*pa(I))[J].get_attributes()
	Next J
Next I

For I As Integer = LBound(pa) To UBound(pa)
'    Delete[] pa(I)  '' does not work
	pa(I)->DeleteSB_launcher()
Next I

Sleep
