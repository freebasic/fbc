'' examples/manual/threads/threadcreate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgThreadCreate
'' --------

Dim Shared terminate As Integer =0

Sub mythread (param As Any Ptr)
  Dim a As Integer, b As Integer
  While 1
	b=0
	While b<80
	  Print "*";
	  a=0
	   While a<&h7ffffff
	     a+=1
	  Wend
	  b+=1
	Wend
	If terminate=1 Then Exit Sub
  Wend
End Sub

Dim thread As Any Ptr
Dim a As Integer, b As Integer

Print "Main program prints dots"
Print "Thread prints asterisks"
thread=ThreadCreate(@mythread,0)
Print "Thread launched";
b=0
  While b<80

	a=0
	 While a<&h3
	    Print ".";
	   a+=1
	Wend
	b+=1
  Wend
terminate=1
Print "Terminate launched";
ThreadWait (thread)
Print "Thread terminated"
Sleep
