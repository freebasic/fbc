'' examples/manual/operator/procptr4.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator PROCPTR (Procedure pointer and vtable index)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpProcptr
'' --------

' Since fbc 1.10.0, ProcPtr allows to access the vtable index of a virtual/abstract member procedure/operator

Type Parent Extends Object
	Declare Abstract Sub test()
	Declare Virtual Operator Cast() As String
End Type

Operator Parent.Cast() As String
	Return "Parent.Cast() As String"
End Operator

Type Child Extends Parent
	Declare Virtual Sub test()                 '' or Declare Sub test()
	Declare Virtual Operator Cast() As String  '' or Declare Operator Cast() As String
End Type

Sub Child.test()
	Print "Child.test()"
End Sub

Operator Child.Cast() As String
	Return "Child.Ccast() As String"
End Operator

Dim As Parent Ptr p = New Child
p->test()
Print Cast(Parent, *p)  '' or Print *p
Print

#define VirtProcPtr(instance, procedure) CPtr(TypeOf(ProcPtr(procedure)), _       '' pointer to virtual procedure
											CPtr(Any Ptr Ptr Ptr, @(instance)) _  '' (the most derived override that exists)
											[0][ProcPtr(procedure, Virtual)])

VirtProcPtr(*p, Parent.test)(*p)        '' execute p->test() through its vtable index
Print VirtProcPtr(*p, Parent.Cast)(*p)  '' execute Cast(Parent, *p) through its vtable index
Print

Delete p
Sleep
