'' examples/manual/proguide/binaries/control-code-fb-profiling.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Profiling with fb's profiler'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProfilingFbProfiler
'' --------

#cmdline "-profgen fb"

Print "__FB_OPTION_PROFILE__ = " & __FB_OPTION_PROFILE__

#pragma push( profile , False )
Print "__FB_OPTION_PROFILE__ = " & __FB_OPTION_PROFILE__
Sleep 100, 1
#pragma pop( profile )

Print "__FB_OPTION_PROFILE__ = " & __FB_OPTION_PROFILE__
