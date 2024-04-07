'' examples/manual/defines/fbminversion.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_MIN_VERSION__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdFBMinVersion
'' --------

#if Not __FB_MIN_VERSION__(0, 18, 2)
 	#error fbc must be at least version 0.18.2 To compile This module
#endif
