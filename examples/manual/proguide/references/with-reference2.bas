'' examples/manual/proguide/references/with-reference2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Using References'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgReferences
'' --------

Type myBase Extends Object
	Declare Virtual Function clone () ByRef As myBase
	Declare Virtual Sub Destroy ()
End Type

Function myBase.clone () ByRef As myBase
	Dim As myBase Ptr pp = New myBase(This)
	Print "myBase.clone() Byref As myBase", pp
	Function = *pp
End Function

Sub myBase.Destroy ()
	Print "myBase.Destroy()", , @This
	Delete @This
End Sub


Type myDerived Extends myBase
	Declare Function clone () ByRef As myDerived Override  '' overriding member function with covariant return
	Declare Sub Destroy () Override                        '' overriding member subroutine
End Type

Function myDerived.clone () ByRef As myDerived      '' overriding member function with covariant return
	Dim As myDerived Ptr pc = New myDerived(This)
	Print "myDerived.clone() Byref As myDerived", pc
	Function = *pc
End Function

Sub myDerived.Destroy ()                '' overriding member subroutine
	Print "myDerived.Destroy()", , @This
	Delete @This
End Sub


Dim As myDerived c

Dim ByRef As myBase rpc = c                '' base type reference to derived object c
Dim ByRef As myDerived rcc = c             '' derived type reference to derived object c

Dim ByRef As myBase rpc1 = rpc.clone()     '' base type reference to clone of object c
'                                               (through its base type reference and polymorphism)
Dim ByRef As myDerived rcc1 = rcc.clone()  '' derived type reference to derived object c
'                                               (through its derived type reference and covariance of return value)
Print
rpc1.Destroy()                             '' using base typpe reference and polymorphism
rcc1.Destroy()                             '' using derived type reference

Sleep
			
