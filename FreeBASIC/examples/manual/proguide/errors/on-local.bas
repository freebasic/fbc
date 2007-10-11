'' examples/manual/proguide/errors/on-local.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgErrorHandling
'' --------

'' Compile with QB (-lang qb) dialect
Declare Sub foo
foo
Sleep

Sub foo
	
	Dim filename As String
	filename = ""
	On Local Error Goto fail
	Open "" For Input As #1
	Print "No error"
	On Local Error Goto 0
	Exit Sub
	
  fail:
	Print ("Error " & Err & " in function " & *Erfn & " on line " & Erl)
	
End Sub
