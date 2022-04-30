'' examples/manual/udt/base.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BASE (member access)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBase
'' --------

Type Parent
	As Integer a
	Declare Constructor(ByVal As Integer = 0)
	Declare Sub show()
End Type

Constructor Parent(ByVal a As Integer = 0)
	This.a = a
End Constructor

Sub Parent.show()
	Print "parent", a
End Sub

Type Child Extends Parent
	As Integer a
	Declare Constructor(ByVal As Integer = 0)
	Declare Sub show()
End Type

Constructor Child(ByVal a As Integer = 0)
	'' Call base type's constructor
	Base(a * 3)
	This.a = a
End Constructor

Sub Child.show()
	'' Call base type's show() method, not ours
	Base.show()
   
	'' Show both a fields, the base type's and ours'
	Print "child", Base.a, a
End Sub

Type GrandChild Extends Child
	As Integer a
	Declare Constructor(ByVal As Integer = 0)
	Declare Sub show()
End Type

Constructor GrandChild(ByVal a As Integer = 0)
	'' Call base type's constructor
	Base(a * 2)
	This.a = a
End Constructor

Sub GrandChild.show()
	'' Call base type's show() method, not ours
	Base.show()
   
	'' Show both a fields, the base.base type's, the base type's and ours'
	Print "grandchild", Base.Base.a, Base.a, a
End Sub

Dim As GrandChild x = GrandChild(3)
x.show()
