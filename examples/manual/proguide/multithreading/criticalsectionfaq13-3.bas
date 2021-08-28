'' examples/manual/proguide/multithreading/criticalsectionfaq13-3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
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

Dim Shared As Double array(1 To 800000)  '' only used by the [For...Next] waiting loop in UserCode()

Function UserCode (ByVal p As Any Ptr) As String
	Dim As String Ptr ps = p
	For I As Integer = 1 To 2
		Print *ps;
		For J As Integer = 1 To 800000
			array(I) = Tan(I) * Atn(I) * Exp(I) * Log(I)  '' [For...Next] waiting loop not freeing any CPU resource
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

Dim As ThreadInitThenMultiStart ts(0 To 31)
Dim As ThreadPooling tp(0 To 31)

'---------------------------------------------------

#macro ThreadInitThenMultiStartSequence(nbThread)
Scope
	Dim As Double t = Timer
	Print "   ";
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
	Dim As Double t = Timer
	Print "   ";
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

'---------------------------------------------------

Print "'ThreadInitThenMultiStart' with 1 secondary thread:"
ThreadInitThenMultiStartSequence(1)

Print "'ThreadPooling' with 1 secondary thread:"
ThreadPoolingSequence(1)
Print

'---------------------------------------------------

Print "'ThreadInitThenMultiStart' with 2 secondary threads:"
ThreadInitThenMultiStartSequence(2)

Print "'ThreadPooling' with 2 secondary threads:"
ThreadPoolingSequence(2)
Print

'---------------------------------------------------

Print "'ThreadInitThenMultiStart' with 4 secondary threads:"
ThreadInitThenMultiStartSequence(4)

Print "'ThreadPooling' with 4 secondary threads:"
ThreadPoolingSequence(4)
Print

'---------------------------------------------------

Print "'ThreadInitThenMultiStart' with 8 secondary threads:"
ThreadInitThenMultiStartSequence(8)

Print "'ThreadPooling' with 8 secondary threads:"
ThreadPoolingSequence(8)
Print

'---------------------------------------------------

Print "'ThreadInitThenMultiStart' with 16 secondary threads:"
ThreadInitThenMultiStartSequence(16)

Print "'ThreadPooling' with 16 secondary threads:"
ThreadPoolingSequence(16)
Print

'---------------------------------------------------

Print "'ThreadInitThenMultiStart' with 32 secondary threads:"
ThreadInitThenMultiStartSequence(32)

Print "'ThreadPooling' with 32 secondary threads:"
ThreadPoolingSequence(32)
Print

Sleep
							
