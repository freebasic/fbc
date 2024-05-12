'' examples/manual/proguide/binaries/call-tree-fb-profiling.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Profiling with fb's profiler'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProfilingFbProfiler
'' --------

#cmdline "-profgen fb" 
#include Once "fbc-int/profile.bi"
Using FBC

ProfileSetOptions( PROFILE_OPTION_REPORT_CALLTREE ) 

Sub A
	Print "A"
End Sub

Sub B
	Print "B"
End Sub

Sub C
	Print "C"
End Sub

Sub D
	Print "D"
	A
	A
	B
	B
	C
	C
End Sub

D
