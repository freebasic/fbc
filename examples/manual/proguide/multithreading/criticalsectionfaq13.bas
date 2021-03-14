'' examples/manual/proguide/multithreading/criticalsectionfaq13.bas
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
			t.Threadwait()          '' waits for the user thread procedure code end
		Next I
		Print
		
		Print "Second user function executed like a thread function:"
		t.ThreadInit(@UserThreadF)  '' initializes the user thread function (used as function)
		For I As UInteger = 1 To 9
			Print I & "^2 = ";
			t.ThreadStart(@I)       '' starts the user thread procedure code body
			Print t.Threadwait()    '' waits for the user thread procedure code end and prints result
		Next I
		Print
		
		Sleep
							
