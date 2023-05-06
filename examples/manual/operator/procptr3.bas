'' examples/manual/operator/procptr3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator PROCPTR (Procedure pointer and vtable index)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpProcptr
'' --------

' Since fbc 1.10.0, ProcPtr supports the member procedures/operators with various syntaxes

Type UDT Extends Object
	Dim As String s1
	Dim As String s2
	Declare Virtual Sub test()
	Declare Virtual Operator Cast() As String
End Type

Sub UDT.test()
	Print This.s1
End Sub

Operator UDT.Cast() As String
	Return This.s2
End Operator

Var testPtr1 = ProcPtr(UDT.test)
Var testPtr2 = ProcPtr(UDT.test, Any)
Var testPtr3 = ProcPtr(UDT.test, Sub())

Dim As Function(ByRef As UDT) As String castPtr1 = ProcPtr(UDT.cast)
Dim As Function(ByRef As UDT) As String castPtr2 = ProcPtr(UDT.cast, Any)
Dim As Function(ByRef As UDT) As String castPtr3 =  ProcPtr(UDT.cast, Function() As String)

Var testIndex1 = ProcPtr(UDT.test, Virtual)
Var testIndex2 = ProcPtr(UDT.test, Virtual Any)
Var testIndex3 = ProcPtr(UDT.test, Virtual Sub())

Dim As Integer castIndex1 = ProcPtr(UDT.cast, Virtual)
Dim As Integer castIndex2 = ProcPtr(UDT.cast, Virtual Any)
Dim As Integer castIndex3 = ProcPtr(UDT.cast, Virtual Function() As String)

Print testPtr1  '' absolue address value of UDT.test pointer
Print testPtr2  '' absolue address value of UDT.test pointer
Print testPtr3  '' absolue address value of UDT.test pointer
Print

Print castPtr1  '' absolue address value of UDT.Cast pointer
Print castPtr2  '' absolue address value of UDT.Cast pointer
Print castPtr3  '' absolue address value of UDT.Cast pointer
Print

Print testIndex1  '' vtable index of UDT.test
Print testIndex2  '' vtable index of UDT.test
Print testIndex3  '' vtable index of UDT.test
Print

Print castIndex1  '' vtable index of UDT.Cast
Print castIndex2  '' vtable index of UDT.Cast
Print castIndex3  '' vtable index of UDT.Cast
Print

Dim As UDT u
u.s1 = "Virtual Sub test()"
u.s2 = "Virtual Operator Cast() As String"

testPtr1(u)  '' execute u.test() through its procedure pointer
testPtr2(u)  '' execute u.test() through its procedure pointer
testPtr3(u)  '' execute u.test() through its procedure pointer
Print

Print castPtr1(u)  '' execute Cast(UDT, u) through its procedure pointer
Print castPtr2(u)  '' execute Cast(UDT, u) through its procedure pointer
Print castPtr3(u)  '' execute Cast(UDT, u) through its procedure pointer
Print

CPtr(Sub(ByRef As UDT), CPtr(Any Ptr Ptr Ptr, @u)[0][testIndex1])(u)  '' execute u.test() through its vtable index
CPtr(Sub(ByRef As UDT), CPtr(Any Ptr Ptr Ptr, @u)[0][testIndex2])(u)  '' execute u.test() through its vtable index
CPtr(Sub(ByRef As UDT), CPtr(Any Ptr Ptr Ptr, @u)[0][testIndex3])(u)  '' execute u.test() through its vtable index
Print

Print CPtr(Function(ByRef As UDT) As String, CPtr(Any Ptr Ptr Ptr, @u)[0][castIndex1])(u)  '' execute Cast(UDT, u) through its vtable index
Print CPtr(Function(ByRef As UDT) As String, CPtr(Any Ptr Ptr Ptr, @u)[0][castIndex2])(u)  '' execute Cast(UDT, u) through its vtable index
Print CPtr(Function(ByRef As UDT) As String, CPtr(Any Ptr Ptr Ptr, @u)[0][castIndex3])(u)  '' execute Cast(UDT, u) through its vtable index
Print

Sleep
