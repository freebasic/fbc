'' examples/manual/defines/fboutlib.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboutlib
'' --------

#if __FB_OUT_LIB__ 
	    '... specific instructions when making a static library
#else
	    '... specific instructions when not making a static library
#endif
