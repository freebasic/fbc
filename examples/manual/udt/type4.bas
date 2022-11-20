'' examples/manual/udt/type4.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'TYPE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgType
'' --------

Type Parent
	Private:
		Dim As String nameParent
		Declare Constructor()
		Declare Constructor(ByRef As Parent)
		Type Child
			Dim As String nameChild
			Dim As Parent Ptr ptrParent
			Declare Sub kinship()
		End Type
		Dim As Child listChild(Any)
	Public:
		Declare Constructor(ByRef _nameParent As String)
		Declare Sub addChild(ByRef _nameChild As String)
		Declare Sub kinship()
End Type

Constructor Parent(ByRef _nameParent As String)
	This.nameParent = _nameParent
End Constructor

Sub Parent.addChild(ByRef _nameChild As String)
	ReDim Preserve This.listChild(UBound(This.listChild) + 1)
	This.listChild(UBound(This.listChild)).nameChild = _nameChild
	This.listChild(UBound(This.listChild)).ptrParent = @This
End Sub

Sub Parent.Child.kinship()
	Print "'" & This.nameChild & "'" & " is child of " & "'" & This.ptrParent->nameParent & "'"
End Sub

Sub Parent.kinship()
	For i As Integer = 0 To UBound(This.listChild)
		This.listChild(i).kinship()
	Next i
End Sub


Dim As Parent p = Parent("Kennedy")
p.addChild("John Jr.")
p.addChild("Caroline")
p.addChild("Patrick")
p.kinship()

Sleep
