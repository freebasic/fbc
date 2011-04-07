'' examples/manual/proguide/sourcefiles.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgSourceFiles
'' --------

	'' sample.bas
	Declare Sub ShowHelp()

	'' This next line is the first executable statement in the program
	If Command(1) = "" Then
		ShowHelp
		End 0
	End If	

	Sub ShowHelp()
		Print "no options specified."	
	End Sub
