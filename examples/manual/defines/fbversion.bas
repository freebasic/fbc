'' examples/manual/defines/fbversion.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_VERSION__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbversion
'' --------

#if __FB_VERSION__ < "0.18" 
#error  Please compile With FB version 0.18 Or above 
#endif
