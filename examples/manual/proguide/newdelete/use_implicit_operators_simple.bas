'' examples/manual/proguide/newdelete/use_implicit_operators_simple.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Use Implicit / Overload New([]) and Delete([]) Operators with Inheritance Polymorphism'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgUseNewDelete
'' --------

' Code for using implicit 'New'/'Delete' operators from base-typed pointer array in polymorphic inheritance context

Type Animal Extends Object
	Public:
		Declare Abstract Sub Init(ByRef _name As String, ByRef _favorite As String)
		Declare Abstract Function get_attributes() As String
		Declare Virtual Destructor()
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
	Private:
		Dim As String favorite
End Type

Constructor Cat ()
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


Type Dog Extends Animal
	Public:
		Declare Constructor()
		Declare Virtual Sub Init(ByRef _name As String, ByRef _favorite As String)
		Declare Virtual Function get_attributes() As String
		Declare Virtual Destructor()
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

'------------------------------------------------------------------------------

Dim As Animal Ptr pa(0 To ...) = {New Cat(), New Cat(), New Dog(), New Dog()}

pa(0)->Init("Tiger", "Salmon")
pa(1)->Init("Kitty", "Sardine")
pa(2)->Init("Buddy", "Lamb")
pa(3)->Init("Molly", "Beef")

For I As Integer = LBound(pa) To UBound(pa)
	Print "    " & pa(I)->get_attributes()
Next I

For I As Integer = LBound(pa) To UBound(pa)
	Delete pa(I)
Next I

Sleep
