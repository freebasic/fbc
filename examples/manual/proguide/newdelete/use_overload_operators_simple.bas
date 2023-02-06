'' examples/manual/proguide/newdelete/use_overload_operators_simple.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Use Implicit / Overload New([]) and Delete([]) Operators with Inheritance Polymorphism'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgUseNewDelete
'' --------

' Code for using overload 'New'/'Delete' operators from base-typed pointer array in polymorphic inheritance context
'    Added member procedure to workaround unexpected behavior:
'       - Abstract/Virtual 'Delete_launcher()' to call the overload Delete operator of the derived type from a base-typed pointer

Type Animal Extends Object
	Public:
		Declare Abstract Sub Init(ByRef _name As String, ByRef _favorite As String)
		Declare Abstract Function get_attributes() As String
		Declare Virtual Destructor()
		Declare Abstract Sub Delete_launcher()
	Protected:
		Dim As String Name
		Declare Constructor()
	Private:
		Declare Constructor(ByRef _a As Animal)
End Type

Destructor Animal ()
	Print "  Animal destructor: ", "  object address: " & @This
End Destructor

Constructor Animal ()
	Print "  Animal constructor: ", "  object address: " & @This
End Constructor


Type Cat Extends Animal
	Public:
		Declare Constructor()
		Declare Virtual Sub Init(ByRef _name As String, ByRef _favorite As String)
		Declare Virtual Function get_attributes() As String
		Declare Virtual Destructor()
		Declare Operator New(ByVal size As UInteger) As Any Ptr
		Declare Operator Delete(ByVal buf As Any Ptr)
		Declare Virtual Sub Delete_launcher()
	Private:
		Dim As String favorite
End Type

Constructor Cat ()
	Print "    Cat constructor: ", "    object address: " & @This
End Constructor

Sub Cat.Init(ByRef _name As String, ByRef _favorite As String = "")
	This.Name = _name
	This.favorite = _favorite
End Sub

Function Cat.get_attributes() As String
	Return This.Name & ": Cat, Meow, " & This.favorite
End Function

Destructor Cat()
	Print "    Cat destructor: ", "    object address: " & @This
End Destructor

Operator Cat.New(ByVal size As UInteger) As Any Ptr
	Dim As Any Ptr p = CAllocate(size)
	Print "Cat New operator: ", "buffer address: " & p
	Return p
End Operator

Operator Cat.Delete(ByVal buf As Any Ptr)
	Print "Cat Delete operator: ", "object address: " & buf
	Deallocate(buf)
End Operator

Sub Cat.Delete_launcher()
	Delete @This
End Sub


Type Dog Extends Animal
	Public:
		Declare Constructor()
		Declare Virtual Sub Init(ByRef _name As String, ByRef _favorite As String)
		Declare Virtual Function get_attributes() As String
		Declare Virtual Destructor()
		Declare Operator New(ByVal size As UInteger) As Any Ptr
		Declare Operator Delete(ByVal buf As Any Ptr)
		Declare Virtual Sub Delete_launcher()
	Private:
		Dim As String favorite
End Type

Constructor Dog()
	Print "    Dog constructor: ", "    object address: " & @This
End Constructor

Sub Dog.Init(ByRef _name As String, ByRef _favorite As String)
	This.Name = _name
	This.favorite = _favorite
End Sub

Function Dog.get_attributes() As String
	Return This.Name & ": Dog, Woof, " & This.favorite
End Function

Destructor Dog()
	Print "    Dog destructor: ", "    object address: " & @This
End Destructor

Operator Dog.New(ByVal size As UInteger) As Any Ptr
	Dim As Any Ptr p = CAllocate(size)
	Print "Dog New operator: ", "buffer address: " & p
	Return p
End Operator

Operator Dog.Delete(ByVal buf As Any Ptr)
	Print "Dog Delete operator: ", "buffer address: " & buf
	Deallocate(buf)
End Operator

Sub Dog.Delete_launcher()
	Delete @This
End Sub

'------------------------------------------------------------------------------

Dim As Animal Ptr pa(0 To ...) = {New Cat(), New Cat(), New Dog(), New Dog()}

pa(0)->Init("Tiger", "Salmon")
pa(1)->Init("Kitty", "Sardine")
pa(2)->Init("Buddy", "Lamb")
pa(3)->Init("Molly", "Beef")

For I As Integer = LBound(pa) To UBound(pa)
	Print "      " & pa(I)->get_attributes()
Next I

For I As Integer = LBound(pa) To UBound(pa)
'    Delete pa(I)  '' does not work
	pa(I)->Delete_launcher()
Next I

Sleep
