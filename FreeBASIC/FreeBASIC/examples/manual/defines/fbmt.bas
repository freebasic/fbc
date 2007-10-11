'' examples/manual/defines/fbmt.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbmt
'' --------

#if __FB_MT__ 
	    #print Using multi-threaded library
#else
	    #print Using Single-threaded library
#endif
