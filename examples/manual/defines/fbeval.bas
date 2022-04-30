'' examples/manual/defines/fbeval.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_EVAL__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbeval
'' --------

#print 1 + 2
#print __FB_EVAL__( 1 + 2 )
#print 4 * Atn(1)
#print __FB_EVAL__( 4 * Atn(1) )

/' Compiler output:
1 + 2
3
4 * Atn(1)
3.141592653589793
'/
	
