'' examples/manual/threads/threadcreate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgThreadCreate
'' --------

Dim Shared terminate As Integer = 0

Sub mythread (param As Any Ptr)	
	
	Dim As Double t = Timer
	While( 1 )
		
		Print "*";
		
		'' pause for .1 second
		While( Abs( Timer - t ) < .1 )
			Sleep 1, 1
		Wend
		t = Timer
		
		If terminate=1 Then Exit Sub
	Wend
	
End Sub

Dim thread As Any Ptr
Dim b As Integer
Dim As Double t

Print "Main program prints dots"
Print "Thread prints asterisks"
thread = ThreadCreate( @mythread, 0 )
Print "Thread launched";

While b < 30
	
	Print ".";
	
	'' pause for .1 second
	While( Abs( Timer - t ) < .1 )
		Sleep 1, 1
	Wend
	t = Timer
	
	b += 1
	
Wend

terminate=1
Print "Terminate launched";
ThreadWait (thread)
Print "Thread terminated"
Sleep
