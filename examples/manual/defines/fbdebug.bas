'' examples/manual/defines/fbdebug.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_DEBUG__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbdebug
'' --------

#if __FB_DEBUG__ <> 0
		#print Debug mode 
#else 
		#print Release mode 
#endif
