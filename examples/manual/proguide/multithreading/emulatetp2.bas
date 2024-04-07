'' examples/manual/proguide/multithreading/emulatetp2.bas
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

Dim As String sa = "  Sequence #a: "
Dim As String sb = "  Sequence #b: "
Dim As String s()

Dim As ThreadPooling t

t.PoolingSubmit(@UserCode1, @sa)
t.PoolingSubmit(@UserCode2)
t.PoolingSubmit(@UserCode3)
Print " Sequence #a of 3 user thread functions fully submitted "
t.PoolingWait()
Print
Print " Sequence #a completed"
Print

t.PoolingSubmit(@UserCode4, @sb)
t.PoolingSubmit(@UserCode5)
t.PoolingSubmit(@UserCode6)
Print " Sequence #b of 3 user thread functions fully submitted "
t.PoolingWait(s())
Print
Print " Sequence #b completed"
Print

Print " List of returned values from sequence #b only"
For I As Integer = LBound(s) To UBound(s)
	Print "  " & I & ": " & s(I)
Next I
Print

Sleep
							
