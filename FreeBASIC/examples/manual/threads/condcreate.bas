'' examples/manual/threads/condcreate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCondCreate
'' --------

Declare Sub mythread( ByVal id_ptr As Any Ptr )

  Dim i As Integer
  Dim Shared hcondready As Any Ptr
  Dim Shared hcondstart As Any Ptr
  Dim threads(1 To 9) As Any Ptr

  '' create conditionals
  hcondready = CondCreate()
  hcondstart = CondCreate()

  If hcondready = 0 Or hcondstart = 0 Then

	Print "Unable to create conditions"

  Else

	Print
	Print "Ready..."
	Print
 
	'' create some threads
	For i = 1 To 9
	  threads(i) = ThreadCreate(@mythread, @i)
	  If threads(i) = 0 Then
	    Print "Unable to create thread"
	  Else
	    '' let the thread tell us it's ready
	    CondWait hcondready
	  End If
	Next i
 
	Print
	Print "Set..."
	Print
 
	Sleep 1000, 1
 
	Print "Go!"
	Print
 
	'' start all threads
	CondBroadcast hcondstart
 
	'' wait for all threads to complete
	For i = 1 To 9
	  If threads(i) <> 0 Then
	    ThreadWait threads(i)
	  End If
	Next i

  End If

  Print
  Print "Done"

  '' Clean up
  If hcondstart Then CondDestroy hcondstart
  If hcondready Then CondDestroy hcondready

  End

Sub mythread( ByVal id_ptr As Any Ptr )

  Dim i As Integer
  Dim id As Integer

  id = *Cast( Integer Ptr, id_ptr )

  Print "Thread #"; id; " is waiting ... "

  '' let the thread creator know we're ready
  CondSignal hcondready

  '' wait for the start signal
  CondWait hcondstart

  '' print out the number of this thread
  For i = 1 To 40
	Print id;
  Next i

End Sub
