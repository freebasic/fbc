'' examples/manual/defines/fbprofile.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_PROFILE__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbprofile
'' --------

#cmdline "-profgen fb"
#include Once "fbc-int/profile.bi"
Using FBC

Print "__FB_PROFILE__ = ";

Select Case __FB_PROFILE__
Case PROFGEN_ID_NONE
	Print "PROFGEN_ID_NONE"
Case PROFGEN_ID_GMON
	Print "PROFGEN_ID_GMON"
Case PROFGEN_ID_CALLS
	Print "PROFGEN_ID_CALLS"
Case PROFGEN_ID_CYCLES
	Print "PROFGEN_ID_CYCLES"
End Select
