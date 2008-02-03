'' examples/manual/defines/fbdebug.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbdebug
'' --------

#if __FB_DEBUG__ <> 0
	    #print Debug mode 
#else 
	    #print Release mode 
#endif
