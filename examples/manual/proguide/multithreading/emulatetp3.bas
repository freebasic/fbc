'' examples/manual/proguide/multithreading/emulatetp3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Emulate a TLS (Thread Local Storage) and a TP (Thread Pooling) feature'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgEmulateTlsTp
'' --------

#include Once "crt/string.bi"

Type ThreadPoolingData
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
End Type

Type ThreadPooling
	Public:
		Declare Constructor()
		Declare Sub PoolingSubmit(ByVal pThread As Function(ByVal As Any Ptr) As String, ByVal p As Any Ptr = 0)
		Declare Sub PoolingWait()
		Declare Sub PoolingWait(values() As String)

		Declare Property PoolingState() As UByte

		Declare Destructor()
	Private:
		Dim As ThreadPoolingData Ptr _pdata
		Declare Static Sub _Thread(ByVal p As Any Ptr)
		Declare Constructor(ByRef t As ThreadPooling)
		Declare Operator Let(ByRef t As ThreadPooling)
End Type

Constructor ThreadPooling()
	This._pdata = New ThreadPoolingData
	With *This._pdata
		ReDim ._pThread(0)
		ReDim ._p(0)
		ReDim ._returnF(0)
		._mutex = MutexCreate()
		._cond1 = CondCreate()
		._cond2 = CondCreate()
		._pt= ThreadCreate(@ThreadPooling._Thread, This._pdata)
	End With
End Constructor

Sub ThreadPooling.PoolingSubmit(ByVal pThread As Function(ByVal As Any Ptr) As String, ByVal p As Any Ptr = 0)
	With *This._pdata
		MutexLock(._mutex)
		ReDim Preserve ._pThread(UBound(._pThread) + 1)
		._pThread(UBound(._pThread)) = pThread
		ReDim Preserve ._p(UBound(._p) + 1)
		._p(UBound(._p)) = p
		CondSignal(._cond2)
		._state = 1
		MutexUnlock(._mutex)
	End With
End Sub

Sub ThreadPooling.PoolingWait()
	With *This._pdata
		MutexLock(._mutex)
		While (._state And 11) > 0
			CondWait(._Cond1, ._mutex)
		Wend
		ReDim ._returnF(0)
		._state = 0
		MutexUnlock(._mutex)
	End With
End Sub

Sub ThreadPooling.PoolingWait(values() As String)
	With *This._pdata
		MutexLock(._mutex)
		While (._state And 11) > 0
			CondWait(._Cond1, ._mutex)
		Wend
		If UBound(._returnF) > 0 Then
			ReDim values(1 To UBound(._returnF))
			For I As Integer = 1 To UBound(._returnF)
				values(I) = ._returnF(I)
			Next I
			ReDim ._returnF(0)
		Else
			Erase values
		End If
		._state = 0
		MutexUnlock(._mutex)
	End With
End Sub

Property ThreadPooling.PoolingState() As UByte
	With *This._pdata
		If UBound(._p) > 0 Then
			Return 8 + ._state
		Else
			Return ._state
		End If
	End With
End Property

Sub ThreadPooling._Thread(ByVal p As Any Ptr)
	Dim As ThreadPoolingData Ptr pdata = p
	With *pdata
		Do
			MutexLock(._mutex)
			If UBound(._pThread) = 0 Then
				._state = 4
				CondSignal(._cond1)
				While UBound(._pThread) = 0
					If ._end = 1 Then Exit Sub
					CondWait(._cond2, ._mutex)
				Wend
			End If
			._pThread0 = ._pThread(1)
			._p0 = ._p(1)
			If UBound(._pThread) > 1 Then
				memmove(@._pThread(1), @._pThread(2), (UBound(._pThread) - 1) * SizeOf(._pThread))
				memmove(@._p(1), @._p(2), (UBound(._p) - 1) * SizeOf(._p))
			End If
			ReDim Preserve ._pThread(UBound(._pThread) - 1)
			ReDim Preserve ._p(UBound(._p) - 1)
			MutexUnlock(._mutex)
			ReDim Preserve ._ReturnF(UBound(._returnF) + 1)
			._state = 2
			._returnF(UBound(._returnF)) = ._pThread0(._p0)
		Loop
	End With
End Sub

Destructor ThreadPooling()
	With *This._pdata
		MutexLock(._mutex)
		._end = 1
		CondSignal(._cond2)
		MutexUnlock(._mutex)
		..ThreadWait(._pt)
		MutexDestroy(._mutex)
		CondDestroy(._cond1)
		CondDestroy(._cond2)
	End With
	Delete This._pdata
End Destructor

'---------------------------------------------------

Type ThreadDispatching
	Public:
		Declare Constructor(ByVal nbMaxSecondaryThread As Integer = 1, ByVal nbMinSecondaryThread As Integer = 0)
		Declare Sub DispatchingSubmit(ByVal pThread As Function(ByVal As Any Ptr) As String, ByVal p As Any Ptr = 0)
		Declare Sub DispatchingWait()
		Declare Sub DispatchingWait(values() As String)

		Declare Property DispatchingThread() As Integer
		Declare Sub DispatchingState(state() As UByte)

		Declare Destructor()
	Private:
		Dim As Integer _nbmst
		Dim As Integer _dstnb
		Dim As ThreadPooling Ptr _tp(Any)
		Declare Constructor(ByRef t As ThreadDispatching)
		Declare Operator Let(ByRef t As ThreadDispatching)
End Type

Constructor ThreadDispatching(ByVal nbMaxSecondaryThread As Integer = 1, ByVal nbMinSecondaryThread As Integer = 0)
	This._nbmst = nbMaxSecondaryThread
	If nbMinSecondaryThread > nbMaxSecondaryThread Then
		nbMinSecondaryThread = nbMaxSecondaryThread
	End If
	If nbMinSecondaryThread > 0 Then
		ReDim This._tp(nbMinSecondaryThread - 1)
		For I As Integer = 0 To nbMinSecondaryThread - 1
			This._tp(I) = New ThreadPooling
		Next I
	End If
End Constructor

Sub ThreadDispatching.DispatchingSubmit(ByVal pThread As Function(ByVal As Any Ptr) As String, ByVal p As Any Ptr = 0)
	For I As Integer = 0 To UBound(This._tp)
		If (This._tp(I)->PoolingState And 11) = 0 Then
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

Sub ThreadDispatching.DispatchingState(state() As UByte)
	If UBound(This._tp) >= 0 Then
		ReDim state(1 To UBound(This._tp) + 1)
		For I As Integer = 0 To UBound(This._tp)
			state(I + 1) = This._tp(I)->PoolingState
		Next I
	End If
End Sub

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
							
