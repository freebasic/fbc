'' examples/manual/proguide/binaries/simple-fb-profiling-cycles.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Profiling with fb's profiler'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProfilingFbProfiler
'' --------

#cmdline "-gen gas64"
#cmdline "-profgen cycles"

Sub A()
	Dim As Integer I
	For J As Integer = 1 To 1000
		I = I + 1
	Next J
End Sub

Sub B()
	A()
End Sub

Sub C()
	B()
	Print "End"
End Sub

C()
