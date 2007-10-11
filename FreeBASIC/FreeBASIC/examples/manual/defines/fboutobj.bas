'' examples/manual/defines/fboutobj.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboutobj
'' --------

#if __FB_OUT_OBJ__ 
	    '... specific instructions when compiling to an object file only
#else
	    '... specific instructions when not compiling to an object file only
#endif
