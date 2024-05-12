'' examples/manual/proguide/binaries/simple-fb-profiling.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Profiling with fb's profiler'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProfilingFbProfiler
'' --------

#cmdline "-profgen fb"

Sub Pause_100
	Sleep 100, 1
End Sub

Sub Pause_200
	Sleep 200, 1
End Sub

Sub Pause_400
	Sleep 400, 1
End Sub

For i As Integer = 1 To 3
	Pause_100
Next i

Pause_200

Pause_400
