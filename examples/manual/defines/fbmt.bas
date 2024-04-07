'' examples/manual/defines/fbmt.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_MT__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbmt
'' --------

#if __FB_MT__ 
		#print Using multi-threaded library
#else
		#print Using Single-threaded library
#endif
