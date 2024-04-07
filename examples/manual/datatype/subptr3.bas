'' examples/manual/datatype/subptr3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SUB Pointer'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSubPtr
'' --------

' Example of advanced callback Sub mechanism (asynchronous) to implement a key pressed event:
' (the user callback Sub address can be modified while the event thread is running)
'   - An asynchronous thread tests the keyboard in a loop, and calls a user callback Sub each time a key is pressed.
'   - An UDT groups the common variables used (callback Sub pointer, character of key pressed, thread end flag),
'       and the static thread Sub plus the thread handle.
'   - An UDT instance pointer is passed to the thread, which then transmits it to the callback Sub each time.
'   - The callback Sub prints the character of the key pressed character,
'       but if the key pressed is <escape> it orders the thread to finish.
'   - As the user callback pointer is a member field of the UDT, it can be modified while the thread is running.


'' UDT for thread environment
  Type threadUDT
	Dim As Sub (ByVal As ThreadUDT Ptr) callback             '' callback Sub pointer
	Dim As Integer threadEnd                                 '' thread end flag
	Dim As String s                                          '' character of the key pressed
	Declare Static Sub threadInkey (ByVal p As Any Ptr)      '' static thread Sub
	Dim As Any Ptr threadHandle                              '' handle to the thread
  End Type

'' thread Sub definition
  Sub threadUDT.threadInkey (ByVal p As Any Ptr)
	Dim As threadUDT Ptr pt = p                              '' convert the any ptr to a threadUDT pointer
	Do
	  pt->s = Inkey
	  If pt->s <> "" AndAlso pt->callback > 0 Then           '' test condition key pressed & callback Sub defined
		pt->callback(p)
	  End If
	  Sleep 50, 1
	Loop Until pt->threadEnd                                 '' test condition to finish thread
  End Sub

'' user callback Sub definition
  Sub printInkey (ByVal pt As threadUDT Ptr)
	If Asc(pt->s) = 27 Then                                  '' test condition key pressed = <escape>
	  pt->threadEnd = -1                                     '' order thread to finish
	  Print
	Else
	  Print pt->s;
	End If
  End Sub

'' user main code
  Dim As ThreadUDT t                                         '' create an instance of threadUDT
  t.threadHandle = ThreadCreate(@threadUDT.threadInkey, @t)  '' launch the thread, passing the instance address
  t.callback = @printInkey                                   '' initialize the callback Sub pointer
  ThreadWait(t.threadHandle)                                 '' wait for the thread finish
