'' examples/manual/proguide/errors/on-local.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgErrorHandling
'' --------

'' Compile with -e
'' The -e command line option is needed to enable error handling.

Declare Sub foo
  foo
Sleep

Sub foo
	
	Dim filename As String
	Dim errmsg As String
	filename = ""
	On Local Error Goto fail
  Open filename For Input Access Read As #1
	Print "No error"
	On Local Error Goto 0
	Exit Sub
	
  fail:
  errmsg = "Error " & Err & _
	       " in function " & *Erfn & _
	       " on line " & Erl
  Print errmsg
	
End Sub
