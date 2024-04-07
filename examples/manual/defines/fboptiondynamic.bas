'' examples/manual/defines/fboptiondynamic.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_OPTION_DYNAMIC__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboptiondynamic
'' --------

#if __FB_OPTION_DYNAMIC__ <> 0
#error This module must Not use Option Dynamic
#endif
