'' examples/manual/defines/fboptionprofile.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_OPTION_PROFILE__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboptionprofile
'' --------

#cmdline "-profgen fb"
' profiling code generated
Print __FB_OPTION_PROFILE__

#pragma profile = False
' profiling code not generated
Print __FB_OPTION_PROFILE__

#pragma profile = True
' profiling code generated
Print __FB_OPTION_PROFILE__
