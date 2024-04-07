'' examples/manual/datatype/funcptr3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FUNCTION Pointer'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFunctionPtr
'' --------

' Example of basic callback Function mechanism (asynchronous) to implement a key pressed event:
' (the user callback Function address cannot be modified while the event thread is running)
'   - An asynchronous thread tests the keyboard in a loop, and calls a user callback Function each time a key is pressed.
'   - The callback Function address is passed to the thread.
'   - The callback Function prints the character of the key pressed,
'       but if the key pressed is <escape> it orders the thread to finish by using the function return value.
'   - As the user callback address is passed to the thread as argument, it cannot be modified while the thread is running.


'' thread Sub definition
  Sub threadInkey (ByVal p As Any Ptr)
	If p > 0 Then                                                '' test condition callback Function defined
	  Dim As Function (ByRef As String) As Integer callback = p  '' convert the any ptr to a callback Function pointer
	  Do
		Dim As String s = Inkey
		If s <> "" Then                                          '' test condition key pressed
		  If callback(s) Then                                    '' test condition to finish thread
			Exit Do
		  End If
		End If
		Sleep 50, 1
	  Loop
	End If
  End Sub

'' user callback Function definition
  Function printInkey (ByRef s As String) As Integer
	If Asc(s) = 27 Then                                        '' test condition key pressed = <escape>
	  Print
	  Return -1                                                '' order thread to finish
	Else
	  Print s;
	  Return 0                                                 '' order thread to continue
	End If
  End Function

'' user main code
  Dim As Any Ptr p = ThreadCreate(@threadInkey, @printInkey)   '' launch the thread, passing the callback Function address
  ThreadWait(p)                                                '' wait for the thread finish
