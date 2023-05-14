'' examples/manual/proguide/multithreading/emulatetp1.bas
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

Function UserThreadS(ByVal p As Any Ptr) As String
	Dim As UInteger Ptr pui = p
	Print *pui * *pui
	Return ""
End Function

Function UserThreadF(ByVal p As Any Ptr) As String
	Dim As UInteger Ptr pui = p
	Dim As UInteger c = (*pui) * (*pui)
	Return Str(c)
End Function

Dim As ThreadInitThenMultiStart t

Print "First user function executed like a thread subroutine:"
t.ThreadInit(@UserThreadS)  '' initializes the user thread function (used as subroutine)
For I As UInteger = 1 To 9
	Print I & "^2 = ";
	t.ThreadStart(@I)       '' starts the user thread procedure code body
	t.ThreadWait()          '' waits for the user thread procedure code end
Next I
Print

Print "Second user function executed like a thread function:"
t.ThreadInit(@UserThreadF)  '' initializes the user thread function (used as function)
For I As UInteger = 1 To 9
	Print I & "^2 = ";
	t.ThreadStart(@I)       '' starts the user thread procedure code body
	Print t.ThreadWait()    '' waits for the user thread procedure code end and prints result
Next I
Print

Sleep
							
