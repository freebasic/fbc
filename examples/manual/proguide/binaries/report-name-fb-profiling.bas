'' examples/manual/proguide/binaries/report-name-fb-profiling.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Profiling with fb's profiler'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProfilingFbProfiler
'' --------

#cmdline "-profgen fb"
#include Once "fbc-int/profile.bi"
Using FBC

'' automatically change the profile report name
Dim t As String = Time
Dim n As String = Left(t, 2) & Mid(t, 4, 2) & Right(t, 2)
ProfileSetFileName( "prof-" & n & ".txt" )
