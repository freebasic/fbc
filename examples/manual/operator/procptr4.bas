'' examples/manual/operator/procptr4.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator PROCPTR (Procedure pointer and vtable index)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpProcptr
'' --------

' Since fbc 1.10.0, ProcPtr also allows to access the vtable index of a virtual/abstract member procedure/operator

Type Parent Extends Object
	Declare Abstract Sub VirtualTest()
	Declare Virtual Operator Cast() As String
	Declare Sub NormalTest()
End Type

Operator Parent.Cast() As String
	Return "Parent.Cast() As String"
End Operator

Sub Parent.NormalTest()
	Print "Parent.NormalTest()"
End Sub

Type Child Extends Parent
	Declare Virtual Sub VirtualTest()          '' or Declare Sub test()
	Declare Virtual Operator Cast() As String  '' or Declare Operator Cast() As String
	Declare Sub NormalTest()
End Type

Sub Child.VirtualTest()
	Print "Child.VirtualTest"
End Sub

Operator Child.Cast() As String
	Return "Child.Cast() As String"
End Operator

Sub Child.NormalTest()
	Print "Child.NormalTest()"
End Sub

Dim As Parent Ptr p = New Child

(*p).VirtualTest()      '' or p->VirtualTest()
Print Cast(Parent, *p)  '' or Print *p
(*p).NormalTest()       '' or p->NormalTest()
Print

#define RuntimeProcPtr(instance, procedure, signature...) _   '' pointer to procedure
	__FB_IIF__(ProcPtr(procedure, Virtual signature) >= 0, _  '' (the most derived override if exists)
			   CPtr(TypeOf(ProcPtr(procedure, signature)), _
					CPtr(Any Ptr Ptr Ptr, @(instance)) _
					[0][ProcPtr(procedure, Virtual signature)]), _
			   ProcPtr(procedure, signature))

'' Here, providing the procedure signature to the macro is useless
'' (because there are no procedure overloads to solve in this case)
RuntimeProcPtr(*p, Parent.VirtualTest)(*p)  '' execute (*p).VirtualTest() through its vtable index
Print RuntimeProcPtr(*p, Parent.Cast)(*p)   '' execute Cast(Parent, *p) through its vtable index
RuntimeProcPtr(*p, Parent.NormalTest)(*p)   '' execute (*p).NormalTest() through its compile address
Print

Delete p
Sleep
