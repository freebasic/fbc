'' examples/manual/input/getkey.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgGetkey
'' --------

Dim As Integer foo
Do
	foo = GetKey
	Print "total return: " & foo
	
	If( foo > 255 ) Then
		Print "extended code: " & (foo And &hff)
		Print "regular code: " & (foo Shr 8)
	Else
		Print "regular code: " & (foo)
	End If
	Print 
Loop Until foo = 27
