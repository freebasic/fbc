'' examples/manual/proguide/binaries/directly-call-fb-profiling.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Profiling with fb's profiler'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProfilingFbProfiler
'' --------

#include Once "fbc-int/profile.bi"
Using FBC

#if __FB_PROFILE__ = PROFILE_OPTION_REPORT_CALLS
#error Do Not compile With -profgen fb
#endif

ProfileInit()

Var ctx = ProfileBeginCall( @"Begin" )

Scope
	Var ctx = ProfileBeginCall( @"Step 1" )
		Sleep 100, 1
	ProfileEndCall( ctx )
End Scope

Scope
	Var ctx = ProfileBeginCall( @"Step 2" )
		Sleep 200, 1
	ProfileEndCall( ctx )
End Scope

ProfileEndCall( ctx )

ProfileEnd(0)
