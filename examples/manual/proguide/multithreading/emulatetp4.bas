'' examples/manual/proguide/multithreading/emulatetp4.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Emulate a TLS (Thread Local Storage) and a TP (Thread Pooling) feature'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgEmulateTlsTp
'' --------

Type ThreadInitThenMultiStartData
	Dim As Function(ByVal p As Any Ptr) As String _pThread
	Dim As Any Ptr _p
	Dim As Any Ptr _mutex1
	Dim As Any Ptr _mutex2
	Dim As Any Ptr _mutex3
	Dim As Any Ptr _pt
	Dim As Byte _end
	Dim As String _returnF
	Dim As UByte _state
End Type

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
		Dim As ThreadInitThenMultiStartData Ptr _pdata
		Declare Static Sub _Thread(ByVal p As Any Ptr)
		Declare Constructor(ByRef t As ThreadInitThenMultiStart)
		Declare Operator Let(ByRef t As ThreadInitThenMultiStart)
End Type

Constructor ThreadInitThenMultiStart()
	This._pdata = New ThreadInitThenMultiStartData
	With *This._pdata
		._mutex1 = MutexCreate()
		MutexLock(._mutex1)
		._mutex2 = MutexCreate()
		MutexLock(._mutex2)
		._mutex3 = MutexCreate()
		MutexLock(._mutex3)
	End With
End Constructor

Sub ThreadInitThenMultiStart.ThreadInit(ByVal pThread As Function(ByVal As Any Ptr) As String, ByVal p As Any Ptr = 0)
	With *This._pdata
		._pThread = pThread
		._p = p
		If ._pt = 0 Then
			._pt= ThreadCreate(@ThreadInitThenMultiStart._Thread, This._pdata)
			MutexUnlock(._mutex3)
			._state = 1
		End If
	End With
End Sub

Sub ThreadInitThenMultiStart.ThreadStart()
	With *This._pdata
		MutexLock(._mutex3)
		MutexUnlock(._mutex1)
	End With
End Sub

Sub ThreadInitThenMultiStart.ThreadStart(ByVal p As Any Ptr)
	With *This._pdata
		MutexLock(._mutex3)
		._p = p
		MutexUnlock(._mutex1)
	End With
End Sub

Function ThreadInitThenMultiStart.ThreadWait() As String
	With *This._pdata
		MutexLock(._mutex2)
		MutexUnlock(._mutex3)
		._state = 1
		Return ._returnF
	End With
End Function

Property ThreadInitThenMultiStart.ThreadState() As UByte
	Return This._pdata->_state
End Property

Sub ThreadInitThenMultiStart._Thread(ByVal p As Any Ptr)
	Dim As ThreadInitThenMultiStartData Ptr pdata = p
	With *pdata
		Do
			MutexLock(._mutex1)
			If ._end = 1 Then Exit Sub
			._state = 2
			._returnF = ._pThread(._p)
			._state = 4
			MutexUnlock(._mutex2)
		Loop
	End With
End Sub

Destructor ThreadInitThenMultiStart()
	With *This._pdata
		If ._pt > 0 Then
			._end = 1
			MutexUnlock(._mutex1)
			..ThreadWait(._pt)
		End If
		MutexDestroy(._mutex1)
		MutexDestroy(._mutex2)
		MutexDestroy(._mutex3)
	End With
	Delete This._pdata
End Destructor

'---------------------------------------------------

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

Dim Shared As Double array(1 To 800000)  '' only used by the [For...Next] waiting loop in UserCode()

Function UserCode (ByVal p As Any Ptr) As String
	Dim As String Ptr ps = p
	For I As Integer = 1 To 2
		Print *ps;
		For J As Integer = 1 To 800000
			array(J) = Tan(J) * Atn(J) * Exp(J) * Log(J)  '' [For...Next] waiting loop not freeing any CPU resource
		Next J
	Next I
	Return ""
End Function

Dim As String s(0 To 31)
For I As Integer = 0 To 15
	s(I) = Str(Hex(I))
Next I
For I As Integer = 16 To 31
	s(I) = Chr(55 + I)
Next I

'---------------------------------------------------

#macro ThreadInitThenMultiStartSequence(nbThread)
Scope
	ReDim As ThreadInitThenMultiStart ts(nbThread - 1)
	Print "   ";
	Dim As Double t = Timer
	For I As Integer = 0 To 32 - nbThread Step nbThread
		For J As Integer = 0 To nbThread - 1
			ts(J).ThreadInit(@UserCode, @s(I + J))
			ts(J).ThreadStart()
		Next J
		For J As Integer = 0 To nbThread - 1
			ts(J).ThreadWait()
		Next J
	Next I
	t = Timer - t
	Print Using " : ####.## s"; t
End Scope
#endmacro

#macro ThreadPoolingSequence(nbThread)
Scope
	ReDim As ThreadPooling tp(nbThread - 1)
	Print "   ";
	Dim As Double t = Timer
	For I As Integer = 0 To 32 - nbThread Step nbThread
		For J As Integer = 0 To nbThread - 1
			tp(J).PoolingSubmit(@UserCode, @s(I + J))
		Next J
	Next I
	For I As Integer = 0 To nbThread - 1
		tp(I).PoolingWait()
	Next I
	t = Timer - t
	Print Using " : ####.## s"; t
End Scope
#endmacro

#macro ThreadDispatchingSequence(nbThreadmax)
Scope
	Dim As ThreadDispatching td##nbThreadmax = nbThreadmax
	Print "   ";
	Dim As Double t = Timer
	For I As Integer = 0 To 31
		td##nbThreadmax.DispatchingSubmit(@UserCode, @s(I))
	Next I
	td##nbThreadmax.DispatchingWait()
	t = Timer - t
	Print Using " : ####.## s"; t
End Scope
#endmacro
   
'---------------------------------------------------

Print "'ThreadInitThenMultiStart' with 1 secondary thread:"
ThreadInitThenMultiStartSequence(1)

Print "'ThreadPooling' with 1 secondary thread:"
ThreadPoolingSequence(1)

Print "'ThreadDispatching' with 1 secondary thread max:"
ThreadDispatchingSequence(1)
Print

'---------------------------------------------------

Print "'ThreadInitThenMultiStart' with 2 secondary threads:"
ThreadInitThenMultiStartSequence(2)

Print "'ThreadPooling' with 2 secondary threads:"
ThreadPoolingSequence(2)

Print "'ThreadDispatching' with 2 secondary threads max:"
ThreadDispatchingSequence(2)
Print

'---------------------------------------------------

Print "'ThreadInitThenMultiStart' with 4 secondary threads:"
ThreadInitThenMultiStartSequence(4)

Print "'ThreadPooling' with 4 secondary threads:"
ThreadPoolingSequence(4)

Print "'ThreadDispatching' with 4 secondary threads max:"
ThreadDispatchingSequence(4)
Print

'---------------------------------------------------

Print "'ThreadInitThenMultiStart' with 8 secondary threads:"
ThreadInitThenMultiStartSequence(8)

Print "'ThreadPooling' with 8 secondary threads:"
ThreadPoolingSequence(8)

Print "'ThreadDispatching' with 8 secondary threads max:"
ThreadDispatchingSequence(8)
Print

'---------------------------------------------------

Print "'ThreadInitThenMultiStart' with 16 secondary threads:"
ThreadInitThenMultiStartSequence(16)

Print "'ThreadPooling' with 16 secondary threads:"
ThreadPoolingSequence(16)

Print "'ThreadDispatching' with 16 secondary threads max:"
ThreadDispatchingSequence(16)
Print

'---------------------------------------------------

Print "'ThreadInitThenMultiStart' with 32 secondary threads:"
ThreadInitThenMultiStartSequence(32)

Print "'ThreadPooling' with 32 secondary threads:"
ThreadPoolingSequence(32)

Print "'ThreadDispatching' with 32 secondary threads max:"
ThreadDispatchingSequence(32)
Print

Sleep
							
