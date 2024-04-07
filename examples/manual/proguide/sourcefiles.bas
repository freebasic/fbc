'' examples/manual/proguide/sourcefiles.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Source Files (.bas)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgSourceFiles
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
