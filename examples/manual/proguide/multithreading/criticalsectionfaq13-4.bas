'' examples/manual/proguide/multithreading/criticalsectionfaq13-4.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

#include Once "crt/string.bi"
Type ThreadPooling
	Public:
		Declare Constructor()
		Declare Sub PoolingSubmit(ByVal pThread As Function(ByVal As Any Ptr) As String, ByVal p As Any Ptr = 0)
		Declare Sub PoolingWait()
		Declare Sub PoolingWait(values() As String)
		Declare Property PoolingState() As UByte
		Declare Destructor()
	Private:
		Dim As Function(ByVal p As Any Ptr) As String _pThread0
		Dim As Any Ptr _p0
		Dim As Function(ByVal p As Any Ptr) As String _pThread(Any)
		Dim As Any Ptr _p(Any)
		Dim As Any Ptr _mutex
		Dim As Any Ptr _cond1
		Dim As Any Ptr _cond2
		Dim As Any Ptr _pt
		Dim As Byte _end
		Dim As String _returnF(Any)
		Dim As UByte _state
		Declare Static Sub _Thread(ByVal p As Any Ptr)
End Type

Constructor ThreadPooling()
	ReDim This._pThread(0)
	ReDim This._p(0)
	ReDim This._returnF(0)
	This._mutex = MutexCreate()
	This._cond1 = CondCreate()
	This._cond2 = CondCreate()
	This._pt= ThreadCreate(@ThreadPooling._Thread, @This)
End Constructor

Sub ThreadPooling.PoolingSubmit(ByVal pThread As Function(ByVal As Any Ptr) As String, ByVal p As Any Ptr = 0)
	MutexLock(This._mutex)
	ReDim Preserve This._pThread(UBound(This._pThread) + 1)
	This._pThread(UBound(This._pThread)) = pThread
	ReDim Preserve This._p(UBound(This._p) + 1)
	This._p(UBound(This._p)) = p
	CondSignal(This._cond2)
	This._state = 1
	MutexUnlock(This._mutex)
End Sub

Sub ThreadPooling.PoolingWait()
	MutexLock(This._mutex)
	While This._state <> 4
		CondWait(This._Cond1, This._mutex)
	Wend
	ReDim This._returnF(0)
	This._state = 0
	MutexUnlock(This._mutex)
End Sub

Sub ThreadPooling.PoolingWait(values() As String)
	MutexLock(This._mutex)
	While This._state <> 4
		CondWait(This._Cond1, This._mutex)
	Wend
	If UBound(This._returnF) > 0 Then
		ReDim values(1 To UBound(This._returnF))
		For I As Integer = 1 To UBound(This._returnF)
			values(I) = This._returnF(I)
		Next I
		ReDim This._returnF(0)
	Else
		Erase values
	End If
	This._state = 0
	MutexUnlock(This._mutex)
End Sub

Property ThreadPooling.PoolingState() As UByte
	Return This._state
End Property

Sub ThreadPooling._Thread(ByVal p As Any Ptr)
	Dim As ThreadPooling Ptr pThis = p
	Do
		MutexLock(pThis->_mutex)
		If UBound(pThis->_pThread) = 0 Then
			pThis->_state = 4
			CondSignal(pThis->_cond1)
			While UBound(pThis->_pThread) = 0
				CondWait(pThis->_cond2, pThis->_mutex)
				If pThis->_end = 1 Then Exit Sub
			Wend
		End If
		pThis->_pThread0 = pThis->_pThread(1)
		pThis->_p0 = pThis->_p(1)
		If UBound(pThis->_pThread) > 1 Then
			memmove(@pThis->_pThread(1), @pThis->_pThread(2), (UBound(pThis->_pThread) - 1) * SizeOf(pThis->_pThread))
			memmove(@pThis->_p(1), @pThis->_p(2), (UBound(pThis->_p) - 1) * SizeOf(pThis->_p))
		End If
		ReDim Preserve pThis->_pThread(UBound(pThis->_pThread) - 1)
		ReDim Preserve pThis->_p(UBound(pThis->_p) - 1)
		MutexUnlock(pThis->_mutex)
		ReDim Preserve pThis->_ReturnF(UBound(pThis->_returnF) + 1)
		pThis->_state = 2
		pThis->_returnF(UBound(pThis->_returnF)) = pThis->_pThread0(pThis->_p0)
	Loop
End Sub

Destructor ThreadPooling()
	MutexLock(This._mutex)
	This._end = 1
	CondSignal(This._cond2)
	MutexUnlock(This._mutex)
	.ThreadWait(This._pt)
	MutexDestroy(This._mutex)
	CondDestroy(This._cond1)
	CondDestroy(This._cond2)
End Destructor

'---------------------------------------------------

Type ThreadDispatching
	Public:
		Declare Constructor(ByVal nbMaxSecondaryThread As Integer = 1)
		Declare Sub DispatchingSubmit(ByVal pThread As Function(ByVal As Any Ptr) As String, ByVal p As Any Ptr = 0)
		Declare Sub DispatchingWait()
		Declare Sub DispatchingWait(values() As String)
		Declare Property DispatchingThread() As Integer
		Declare Destructor()
	Private:
		Dim As Integer _nbmst
		Dim As Integer _dstnb
		Dim As ThreadPooling Ptr _tp(Any)
End Type

Constructor ThreadDispatching(ByVal nbMaxSecondaryThread As Integer = 1)
	This._nbmst = nbMaxSecondaryThread
End Constructor

Sub ThreadDispatching.DispatchingSubmit(ByVal pThread As Function(ByVal As Any Ptr) As String, ByVal p As Any Ptr = 0)
	For I As Integer = 0 To UBound(This._tp)
		If (This._tp(I)->PoolingState And 3) = 0 Then
			This._tp(I)->PoolingSubmit(pThread, p)
			Exit Sub
		End If
	Next I
	If UBound(This._tp) < This._nbmst - 1 Then
		ReDim Preserve This._tp(UBound(This._tp) + 1)
		This._tp(UBound(This._tp)) = New ThreadPooling
		This._tp(UBound(This._tp))->PoolingSubmit(pThread, p)
	ElseIf UBound(This._tp) >= 0 Then
		This._tp(This._dstnb)->PoolingSubmit(pThread, p)
		This._dstnb = (This._dstnb + 1) Mod This._nbmst
	End If
End Sub

Sub ThreadDispatching.DispatchingWait()
	For I As Integer = 0 To UBound(This._tp)
		This._tp(I)->PoolingWait()
	Next I
End Sub

Sub ThreadDispatching.DispatchingWait(values() As String)
	Dim As String s()
	For I As Integer = 0 To UBound(This._tp)
		This._tp(I)->PoolingWait(s())
		If UBound(s) >= 1 Then
			If UBound(values) = -1 Then
				ReDim Preserve values(1 To UBound(values) + UBound(s) + 1)
			Else
				ReDim Preserve values(1 To UBound(values) + UBound(s))
			End If
			For I As Integer = 1 To UBound(s)
				values(UBound(values) - UBound(s) + I) = s(I)
			Next I
		End If
	Next I
End Sub

Property ThreadDispatching.DispatchingThread() As Integer
	Return UBound(This._tp) + 1
End Property

Destructor ThreadDispatching()
	For I As Integer = 0 To UBound(This._tp)
		Delete This._tp(I)
	Next I
End Destructor

'---------------------------------------------------

Sub Prnt (ByRef s As String, ByVal p As Any Ptr)
	Dim As String Ptr ps = p
	If ps > 0 Then Print *ps;
	For I As Integer = 1 To 10
		Print s;
		Sleep 100, 1
	Next I
End Sub

Function UserCode1 (ByVal p As Any Ptr) As String
	Prnt("1", p)
	Return "UserCode #1"
End Function

Function UserCode2 (ByVal p As Any Ptr) As String
	Prnt("2", p)
	Return "UserCode #2"
End Function

Function UserCode3 (ByVal p As Any Ptr) As String
	Prnt("3", p)
	Return "UserCode #3"
End Function

Function UserCode4 (ByVal p As Any Ptr) As String
	Prnt("4", p)
	Return "UserCode #4"
End Function

Function UserCode5 (ByVal p As Any Ptr) As String
	Prnt("5", p)
	Return "UserCode #5"
End Function

Function UserCode6 (ByVal p As Any Ptr) As String
	Prnt("6", p)
	Return "UserCode #6"
End Function

Sub SubmitSequence(ByRef t As ThreadDispatching, ByVal ps As String Ptr)
	t.DispatchingSubmit(@UserCode1, ps)
	t.DispatchingSubmit(@UserCode2)
	t.DispatchingSubmit(@UserCode3)
	t.DispatchingSubmit(@UserCode4)
	t.DispatchingSubmit(@UserCode5)
	t.DispatchingSubmit(@UserCode6)
End Sub   

Dim As String sa = "  Sequence #a: "
Dim As String sb = "  Sequence #b: "
Dim As String sc = "  Sequence #c: "
Dim As String sd = "  Sequence #d: "
Dim As String se = "  Sequence #e: "
Dim As String sf = "  Sequence #f: "
Dim As String s()

Dim As ThreadDispatching t1, t2 = 2, t3 = 3, t4 = 4, t5 = 5, t6 = 6

Print " Sequence #a of 6 user thread functions dispatched over 1 secondary thread:"
SubmitSequence(t1, @sa)
t1.DispatchingWait()
Print
Print

Print " Sequence #b of 6 user thread functions dispatched over 2 secondary threads:"
SubmitSequence(t2, @sb)
t2.DispatchingWait()
Print
Print

Print " Sequence #c of 6 user thread functions dispatched over 3 secondary threads:"
SubmitSequence(t3, @sc)
t3.DispatchingWait()
Print
Print

Print " Sequence #d of 6 user thread functions dispatched over 4 secondary threads:"
SubmitSequence(t4, @sd)
t4.DispatchingWait()
Print
Print

Print " Sequence #e of 6 user thread functions dispatched over 5 secondary threads:"
SubmitSequence(t5, @se)
t5.DispatchingWait()
Print
Print

Print " Sequence #f of 6 user thread functions dispatched over 6 secondary threads:"
SubmitSequence(t6, @sf)
t6.DispatchingWait(s())
Print

Print "  List of returned values from sequence #f:"
For I As Integer = LBound(s) To UBound(s)
	Print "   " & I & ": " & s(I)
Next I

Sleep
							
