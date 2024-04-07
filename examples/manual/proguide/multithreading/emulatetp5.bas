'' examples/manual/proguide/multithreading/emulatetp5.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Emulate a TLS (Thread Local Storage) and a TP (Thread Pooling) feature'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgEmulateTlsTp
'' --------

Type ThreadInitThenMultiStart
	Public:
		Declare Constructor()
		Declare Sub ThreadInit(ByVal pThread As Function(ByVal As Any Ptr) As String, ByVal p As Any Ptr = 0)
		Declare Sub ThreadStart()
		Declare Sub ThreadStart(ByVal p As Any Ptr)
		Declare Function ThreadWait() As String

		Declare Property ThreadState() As UByte

		Declare Destructor()
	Private:
		Dim As Function(ByVal p As Any Ptr) As String _pThread
		Dim As Any Ptr _p
		Dim As Any Ptr _mutex1
		Dim As Any Ptr _mutex2
		Dim As Any Ptr _mutex3
		Dim As Any Ptr _pt
		Dim As Byte _end
		Dim As String _returnF
		Dim As UByte _state
		Declare Static Sub _Thread(ByVal p As Any Ptr)
End Type

Constructor ThreadInitThenMultiStart()
	This._mutex1 = MutexCreate()
	MutexLock(This._mutex1)
	This._mutex2 = MutexCreate()
	MutexLock(This._mutex2)
	This._mutex3 = MutexCreate()
	MutexLock(This._mutex3)
End Constructor

Sub ThreadInitThenMultiStart.ThreadInit(ByVal pThread As Function(ByVal As Any Ptr) As String, ByVal p As Any Ptr = 0)
	This._pThread = pThread
	This._p = p
	If This._pt = 0 Then
		This._pt= ThreadCreate(@ThreadInitThenMultiStart._Thread, @This)
		MutexUnlock(This._mutex3)
		This._state = 1
	End If
End Sub

Sub ThreadInitThenMultiStart.ThreadStart()
	MutexLock(This._mutex3)
	MutexUnlock(This._mutex1)
End Sub

Sub ThreadInitThenMultiStart.ThreadStart(ByVal p As Any Ptr)
	MutexLock(This._mutex3)
	This._p = p
	MutexUnlock(This._mutex1)
End Sub

Function ThreadInitThenMultiStart.ThreadWait() As String
	MutexLock(This._mutex2)
	MutexUnlock(This._mutex3)
	This._state = 1
	Return This._returnF
End Function

Property ThreadInitThenMultiStart.ThreadState() As UByte
	Return This._state
End Property

Sub ThreadInitThenMultiStart._Thread(ByVal p As Any Ptr)
	Dim As ThreadInitThenMultiStart Ptr pThis = p
	Do
		MutexLock(pThis->_mutex1)
		If pThis->_end = 1 Then Exit Sub
		pThis->_state = 2
		pThis->_returnF = pThis->_pThread(pThis->_p)
		pThis->_state = 4
		MutexUnlock(pThis->_mutex2)
	Loop
End Sub

Destructor ThreadInitThenMultiStart()
	If This._pt > 0 Then
		This._end = 1
		MutexUnlock(This._mutex1)
		.ThreadWait(This._pt)
	End If
	MutexDestroy(This._mutex1)
	MutexDestroy(This._mutex2)
	MutexDestroy(This._mutex3)
End Destructor

'---------------------------------------------------

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
	While (This._state And 11) > 0
		CondWait(This._Cond1, This._mutex)
	Wend
	ReDim This._returnF(0)
	This._state = 0
	MutexUnlock(This._mutex)
End Sub

Sub ThreadPooling.PoolingWait(values() As String)
	MutexLock(This._mutex)
	While (This._state And 11) > 0
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
	If UBound(This._p) > 0 Then
		Return 8 + This._state
	Else
		Return This._state
	End If
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

Sub s(ByVal p As Any Ptr)
	'' user task
End Sub

Function f(ByVal p As Any Ptr) As String
	'' user task
	Return ""
End Function

'---------------------------------------------------
'Time wasted when running a user task either by procedure calling or by various threading methods
Print "Mean time wasted when running a user task :"
Print "   either by procedure calling method,"
Print "   or by various threading methods."
Print

Scope
	Dim As Double t = Timer
	For I As Integer = 1 To 1000000
		s(0)
	Next I
	t = Timer - t
	Print Using "      - Using procedure calling method        : ###.###### ms"; t / 1000
	Print
End Scope

Scope
	Dim As Any Ptr P
	Dim As Double t = Timer
	For I As Integer = 1 To 1000
		p = ThreadCreate(@s)
		ThreadWait(p)
	Next I
	t = Timer - t
	Print Using "      - Using elementary threading method     : ###.###### ms"; t
	Print
End Scope

Scope
	Dim As ThreadInitThenMultiStart ts
	Dim As Double t = Timer
	ts.ThreadInit(@f)
	For I As Integer = 1 To 10000
		ts.ThreadStart()
		ts.ThreadWait()
	Next I
	t = Timer - t
	Print Using "      - Using ThreadInitThenMultiStart method : ###.###### ms"; t / 10
End Scope

Scope
	Dim As ThreadPooling tp
	Dim As Double t = Timer
	For I As Integer = 1 To 10000
		tp.PoolingSubmit(@f)
	Next I
	tp.PoolingWait()
	t = Timer - t
	Print Using "      - Using ThreadPooling method            : ###.###### ms"; t / 10
End Scope

Scope
	Dim As ThreadDispatching td
	Dim As Double t = Timer
	For I As Integer = 1 To 10000
		td.DispatchingSubmit(@f)
	Next I
	td.DispatchingWait()
	t = Timer - t
	Print Using "      - Using ThreadDispatching method        : ###.###### ms"; t / 10
End Scope

Print
Sleep
					
