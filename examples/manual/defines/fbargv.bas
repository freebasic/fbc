'' examples/manual/defines/fbargv.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_ARGV__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbargv
'' --------

Sub displayCommandLineArguments( ByVal argc As Integer, ByVal argv As ZString Ptr Ptr )
	Dim i As Integer
	For i = 0 To argc - 1
		Print "arg "; i; " = '"; *argv[i]; "'"
	Next i
End Sub

displayCommandLineArguments( __FB_ARGC__, __FB_ARGV__ )

Sleep
