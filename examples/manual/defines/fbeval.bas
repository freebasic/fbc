'' examples/manual/defines/fbeval.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
	
