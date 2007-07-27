'' examples/manual/procs/mod-dtor.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgModuleDestructor
'' --------

Sub pauseonexit Destructor
	
	'' If the program reaches the end, or aborts with an error, 
	'' it will run this destructor before closing
	
	Print "Press any key to end the program..."
	Sleep
	
End Sub

Dim array(0 To 10, 0 To 10) As Integer
Dim As Integer i = 0, j = 11

'' this next line will cause the program to abort with an 
'' error if you compile with array bounds checking enabled (fbc -exx ...)
Print array(i, j)
